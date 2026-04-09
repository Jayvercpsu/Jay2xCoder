import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/providers/app_providers.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, this.lessonId});

  final String? lessonId;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  final TextEditingController _editorController = TextEditingController();
  final ScrollController _editorScrollController = ScrollController();
  final ScrollController _lineNumbersScrollController = ScrollController();

  Directory? _workspaceRoot;
  List<Directory> _projects = <Directory>[];
  Directory? _selectedProject;
  List<File> _projectFiles = <File>[];
  File? _selectedFile;
  bool _memoryMode = false;
  bool _suppressEditorChanged = false;
  final Map<String, Map<String, String>> _memoryWorkspace =
      <String, Map<String, String>>{};
  String? _memorySelectedProject;
  String? _memorySelectedFile;

  bool _loading = true;
  bool _explorerOpen = false;
  bool _consoleOpen = false;
  bool _saving = false;
  bool _landscapeOnly = false;
  String _consoleText =
      'Console ready. Create/open a project, then tap Run to build.';

  Timer? _autoSaveDebounce;

  void _setEditorTextSilently(String content) {
    _suppressEditorChanged = true;
    _editorController.value = TextEditingValue(
      text: content,
      selection: TextSelection.collapsed(offset: content.length),
    );
    _suppressEditorChanged = false;
  }

  @override
  void initState() {
    super.initState();
    _editorScrollController.addListener(_syncLineNumbers);
    Future<void>.microtask(_initializeWorkspace);
  }

  @override
  void dispose() {
    _autoSaveDebounce?.cancel();
    unawaited(
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
    );
    _editorScrollController
      ..removeListener(_syncLineNumbers)
      ..dispose();
    _lineNumbersScrollController.dispose();
    _editorController.dispose();
    super.dispose();
  }

  Future<void> _initializeWorkspace() async {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    if (kIsWeb) {
      _memoryMode = true;
      await _reloadWorkspace();
      return;
    }

    try {
      final Directory root = await _resolveWorkspaceRoot();
      if (!await root.exists()) {
        await root.create(recursive: true);
      }

      await _ensureAtLeastOneProject(root);
      await _reloadWorkspace();
    } catch (_) {
      _memoryMode = true;
      await _reloadWorkspace();
    }
  }

  void _syncLineNumbers() {
    if (!_lineNumbersScrollController.hasClients ||
        !_editorScrollController.hasClients) {
      return;
    }
    final double offset = _editorScrollController.offset;
    if ((_lineNumbersScrollController.offset - offset).abs() > 1) {
      _lineNumbersScrollController.jumpTo(offset);
    }
  }

  Future<Directory> _resolveWorkspaceRoot() async {
    Directory? baseDirectory;
    try {
      baseDirectory = await getExternalStorageDirectory();
    } catch (_) {
      baseDirectory = null;
    }
    baseDirectory ??= await getApplicationDocumentsDirectory();
    return Directory(
      '${baseDirectory.path}${Platform.pathSeparator}Jay2xCoder Projects',
    );
  }

  Future<void> _ensureAtLeastOneProject(Directory root) async {
    final List<Directory> directories = root
        .listSync(followLinks: false)
        .whereType<Directory>()
        .toList();

    if (directories.isNotEmpty) {
      return;
    }

    final Directory starter = Directory(
      '${root.path}${Platform.pathSeparator}MyFirstProject',
    );
    await starter.create(recursive: true);
    await _ensureDefaultFiles(starter);
  }

  Future<void> _ensureDefaultFiles(Directory projectDirectory) async {
    final File html = File(
      '${projectDirectory.path}${Platform.pathSeparator}index.html',
    );
    final File css = File(
      '${projectDirectory.path}${Platform.pathSeparator}style.css',
    );
    final File js = File(
      '${projectDirectory.path}${Platform.pathSeparator}script.js',
    );

    if (!await html.exists()) {
      await html.writeAsString(_defaultHtmlTemplate());
    }
    if (!await css.exists()) {
      await css.writeAsString(_defaultCssTemplate());
    }
    if (!await js.exists()) {
      await js.writeAsString(_defaultJsTemplate());
    }
  }

  Future<void> _reloadWorkspace({
    String? selectProjectName,
    String? selectFileName,
  }) async {
    if (_memoryMode) {
      await _reloadMemoryWorkspace(
        selectProjectName: selectProjectName,
        selectFileName: selectFileName,
      );
      return;
    }

    final Directory root = _workspaceRoot ?? await _resolveWorkspaceRoot();
    if (!await root.exists()) {
      await root.create(recursive: true);
    }

    List<Directory> projects = root
        .listSync(followLinks: false)
        .whereType<Directory>()
        .toList();
    projects.sort((Directory a, Directory b) {
      return _entityName(
        a,
      ).toLowerCase().compareTo(_entityName(b).toLowerCase());
    });

    if (projects.isEmpty) {
      await _ensureAtLeastOneProject(root);
      projects =
          root.listSync(followLinks: false).whereType<Directory>().toList()
            ..sort((Directory a, Directory b) {
              return _entityName(
                a,
              ).toLowerCase().compareTo(_entityName(b).toLowerCase());
            });
    }

    Directory projectToOpen = projects.first;
    if (selectProjectName != null) {
      final Directory? found = projects
          .where(
            (Directory directory) =>
                _entityName(directory) == selectProjectName,
          )
          .firstOrNull;
      if (found != null) {
        projectToOpen = found;
      }
    } else if (_selectedProject != null) {
      final Directory? existing = projects
          .where(
            (Directory directory) => directory.path == _selectedProject!.path,
          )
          .firstOrNull;
      if (existing != null) {
        projectToOpen = existing;
      }
    }

    final List<File> files = await _loadProjectFiles(projectToOpen);
    final File fileToOpen = _chooseFileToOpen(files, selectFileName);
    final String content = await fileToOpen.readAsString();

    if (!mounted) {
      return;
    }

    _setEditorTextSilently(content);
    setState(() {
      _workspaceRoot = root;
      _projects = projects;
      _selectedProject = projectToOpen;
      _projectFiles = files;
      _selectedFile = fileToOpen;
      _loading = false;
    });
  }

  Future<void> _reloadMemoryWorkspace({
    String? selectProjectName,
    String? selectFileName,
  }) async {
    if (_memoryWorkspace.isEmpty) {
      _memoryWorkspace['MyFirstProject'] = <String, String>{
        'index.html': _defaultHtmlTemplate(),
        'style.css': _defaultCssTemplate(),
        'script.js': _defaultJsTemplate(),
      };
    }

    final List<String> projectNames = _memoryWorkspace.keys.toList()
      ..sort(
        (String a, String b) => a.toLowerCase().compareTo(b.toLowerCase()),
      );

    String projectToOpen = projectNames.first;
    if (selectProjectName != null &&
        _memoryWorkspace.containsKey(selectProjectName)) {
      projectToOpen = selectProjectName;
    } else if (_memorySelectedProject != null &&
        _memoryWorkspace.containsKey(_memorySelectedProject)) {
      projectToOpen = _memorySelectedProject!;
    }

    final Map<String, String> filesMap = _memoryWorkspace[projectToOpen]!;
    if (filesMap.isEmpty) {
      filesMap['index.html'] = _defaultHtmlTemplate();
      filesMap['style.css'] = _defaultCssTemplate();
      filesMap['script.js'] = _defaultJsTemplate();
    }

    final List<String> fileNames = filesMap.keys.toList()
      ..sort((String a, String b) {
        final int first = _filePriority(a);
        final int second = _filePriority(b);
        if (first != second) {
          return first.compareTo(second);
        }
        return a.toLowerCase().compareTo(b.toLowerCase());
      });

    String fileToOpen = fileNames.first;
    if (selectFileName != null && filesMap.containsKey(selectFileName)) {
      fileToOpen = selectFileName;
    } else if (_memorySelectedFile != null &&
        filesMap.containsKey(_memorySelectedFile)) {
      fileToOpen = _memorySelectedFile!;
    }

    final Directory root = Directory('/Jay2xCoder Projects');
    final List<Directory> projects = projectNames
        .map((String name) => Directory('/Jay2xCoder Projects/$name'))
        .toList();
    final List<File> files = fileNames
        .map((String name) => File('/Jay2xCoder Projects/$projectToOpen/$name'))
        .toList();
    final String content = filesMap[fileToOpen] ?? '';

    if (!mounted) {
      return;
    }

    _setEditorTextSilently(content);
    setState(() {
      _workspaceRoot = root;
      _projects = projects;
      _selectedProject = Directory('/Jay2xCoder Projects/$projectToOpen');
      _projectFiles = files;
      _selectedFile = File('/Jay2xCoder Projects/$projectToOpen/$fileToOpen');
      _memorySelectedProject = projectToOpen;
      _memorySelectedFile = fileToOpen;
      _loading = false;
    });
  }

  Future<List<File>> _loadProjectFiles(Directory project) async {
    List<File> files = project
        .listSync(followLinks: false)
        .whereType<File>()
        .where(_isSupportedCodeFile)
        .toList();

    if (files.isEmpty) {
      await _ensureDefaultFiles(project);
      files = project
          .listSync(followLinks: false)
          .whereType<File>()
          .where(_isSupportedCodeFile)
          .toList();
    }

    files.sort((File a, File b) {
      final int first = _filePriority(a.path);
      final int second = _filePriority(b.path);
      if (first != second) {
        return first.compareTo(second);
      }
      return _entityName(
        a,
      ).toLowerCase().compareTo(_entityName(b).toLowerCase());
    });

    return files;
  }

  File _chooseFileToOpen(List<File> files, String? preferredName) {
    if (preferredName != null) {
      final File? match = files
          .where((File f) => _entityName(f) == preferredName)
          .firstOrNull;
      if (match != null) {
        return match;
      }
    }
    if (_selectedFile != null) {
      final File? stillExists = files
          .where((File file) => file.path == _selectedFile!.path)
          .firstOrNull;
      if (stillExists != null) {
        return stillExists;
      }
    }
    return files.first;
  }

  int _filePriority(String path) {
    switch (_extension(path)) {
      case 'html':
        return 0;
      case 'css':
        return 1;
      case 'js':
        return 2;
      default:
        return 99;
    }
  }

  bool _isSupportedCodeFile(File file) {
    final String ext = _extension(file.path);
    return ext == 'html' || ext == 'css' || ext == 'js';
  }

  String _extension(String path) {
    final int index = path.lastIndexOf('.');
    if (index < 0 || index == path.length - 1) {
      return '';
    }
    return path.substring(index + 1).toLowerCase();
  }

  String _entityName(FileSystemEntity entity) {
    final List<String> chunks = entity.path
        .split(Platform.pathSeparator)
        .where((String segment) => segment.isNotEmpty)
        .toList();
    return chunks.isEmpty ? entity.path : chunks.last;
  }

  Future<void> _switchProject(Directory project) async {
    if (_memoryMode) {
      _memorySelectedProject = _entityName(project);
      await _reloadWorkspace(selectProjectName: _memorySelectedProject);
      return;
    }
    await _saveCurrentFile(silent: true);
    await _reloadWorkspace(selectProjectName: _entityName(project));
  }

  Future<void> _openFile(File file) async {
    if (_selectedFile?.path == file.path) {
      return;
    }
    await _saveCurrentFile(silent: true);
    if (_memoryMode) {
      final String projectName =
          _memorySelectedProject ?? _entityName(_selectedProject!);
      final String fileName = _entityName(file);
      final String content = _memoryWorkspace[projectName]?[fileName] ?? '';

      if (!mounted) {
        return;
      }
      _setEditorTextSilently(content);
      setState(() {
        _selectedFile = file;
        _memorySelectedFile = fileName;
      });
      return;
    }

    final String content = await file.readAsString();

    if (!mounted) {
      return;
    }
    _setEditorTextSilently(content);
    setState(() {
      _selectedFile = file;
    });
  }

  Future<void> _saveCurrentFile({bool silent = false}) async {
    final File? target = _selectedFile;
    if (target == null) {
      return;
    }

    if (mounted) {
      setState(() {
        _saving = true;
      });
    }

    if (_memoryMode) {
      final String projectName =
          _memorySelectedProject ?? _entityName(_selectedProject!);
      final String fileName = _entityName(target);
      _memoryWorkspace[projectName] ??= <String, String>{};
      _memoryWorkspace[projectName]![fileName] = _editorController.text;
    } else {
      await target.writeAsString(_editorController.text);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _saving = false;
    });

    if (!silent) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Saved ${_entityName(target)}')));
    }
  }

  void _onEditorChanged() {
    if (_suppressEditorChanged) {
      return;
    }
    _autoSaveDebounce?.cancel();
    _autoSaveDebounce = Timer(const Duration(milliseconds: 800), () {
      _saveCurrentFile(silent: true);
    });

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _createProject() async {
    String draftName = '';
    final String? input = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Create Project'),
          content: SingleChildScrollView(
            child: TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              onChanged: (String value) {
                draftName = value;
              },
              onFieldSubmitted: (String value) {
                FocusScope.of(context).unfocus();
                Navigator.pop(context, value.trim());
              },
              decoration: const InputDecoration(
                hintText: 'e.g. PortfolioSite',
                labelText: 'Project name',
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context, draftName.trim());
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (input == null) {
      return;
    }

    final String sanitized = _sanitizeName(input);
    if (sanitized.isEmpty) {
      return;
    }

    if (_memoryMode) {
      if (_memoryWorkspace.containsKey(sanitized)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Project already exists.')),
          );
        }
        return;
      }
      _memoryWorkspace[sanitized] = <String, String>{
        'index.html': _defaultHtmlTemplate(),
        'style.css': _defaultCssTemplate(),
        'script.js': _defaultJsTemplate(),
      };
      _memorySelectedProject = sanitized;
      _memorySelectedFile = 'index.html';
      await _reloadWorkspace(selectProjectName: sanitized);
      return;
    }

    if (_workspaceRoot == null) {
      return;
    }

    final Directory project = Directory(
      '${_workspaceRoot!.path}${Platform.pathSeparator}$sanitized',
    );
    if (await project.exists()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project already exists.')),
        );
      }
      return;
    }

    await project.create(recursive: true);
    await _ensureDefaultFiles(project);
    await _reloadWorkspace(selectProjectName: _entityName(project));
  }

  Future<void> _createFile() async {
    if (_selectedProject == null) {
      return;
    }

    final _NewFileRequest? request = await _showCreateFileDialog();
    if (request == null) {
      return;
    }

    final String cleanBase = _sanitizeName(request.baseName);
    if (cleanBase.isEmpty) {
      return;
    }

    final String extension = request.fileType;
    final String finalName = cleanBase.endsWith('.$extension')
        ? cleanBase
        : '$cleanBase.$extension';

    if (_memoryMode) {
      final String projectName =
          _memorySelectedProject ?? _entityName(_selectedProject!);
      _memoryWorkspace[projectName] ??= <String, String>{};
      if (_memoryWorkspace[projectName]!.containsKey(finalName)) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('File already exists.')));
        }
        return;
      }

      _memoryWorkspace[projectName]![finalName] = _templateFor(
        extension,
        finalName,
      );
      _memorySelectedFile = finalName;
      await _reloadWorkspace(
        selectProjectName: projectName,
        selectFileName: finalName,
      );
      return;
    }

    final File newFile = File(
      '${_selectedProject!.path}${Platform.pathSeparator}$finalName',
    );
    if (await newFile.exists()) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('File already exists.')));
      }
      return;
    }

    await newFile.writeAsString(_templateFor(extension, finalName));
    await _reloadWorkspace(
      selectProjectName: _entityName(_selectedProject!),
      selectFileName: finalName,
    );
  }

  Future<void> _renameFile(File file) async {
    final String oldName = _entityName(file);
    final int dotIndex = oldName.lastIndexOf('.');
    final String oldBase = dotIndex > 0
        ? oldName.substring(0, dotIndex)
        : oldName;
    final String extension = _extension(oldName);
    String draftBase = oldBase;

    final String? newBase = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Rename File'),
          content: SingleChildScrollView(
            child: TextFormField(
              initialValue: oldBase,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onChanged: (String value) {
                draftBase = value;
              },
              onFieldSubmitted: (String value) {
                FocusScope.of(context).unfocus();
                Navigator.pop(context, value.trim());
              },
              decoration: InputDecoration(
                labelText: 'File name',
                hintText: 'Enter new file name',
                suffixText: extension.isEmpty ? null : '.$extension',
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context, draftBase.trim());
                    },
                    child: const Text('Rename'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (newBase == null) {
      return;
    }

    final String cleanBase = _sanitizeName(newBase);
    if (cleanBase.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid file name.')));
      }
      return;
    }

    final String newName = extension.isEmpty
        ? cleanBase
        : '$cleanBase.$extension';
    if (newName == oldName) {
      return;
    }

    if (_memoryMode) {
      final String projectName =
          _memorySelectedProject ?? _entityName(_selectedProject!);
      final Map<String, String>? files = _memoryWorkspace[projectName];
      if (files == null || !files.containsKey(oldName)) {
        return;
      }
      if (files.containsKey(newName)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('A file with that name already exists.'),
            ),
          );
        }
        return;
      }

      final String content = files.remove(oldName) ?? '';
      files[newName] = content;
      if (_memorySelectedFile == oldName) {
        _memorySelectedFile = newName;
      }
      await _reloadWorkspace(
        selectProjectName: projectName,
        selectFileName: newName,
      );
      return;
    }

    if (_selectedProject == null) {
      return;
    }

    final String targetPath =
        '${_selectedProject!.path}${Platform.pathSeparator}$newName';
    final File target = File(targetPath);
    if (await target.exists()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A file with that name already exists.'),
          ),
        );
      }
      return;
    }

    await file.rename(targetPath);
    await _reloadWorkspace(
      selectProjectName: _entityName(_selectedProject!),
      selectFileName: newName,
    );
  }

  Future<void> _deleteFile(File file) async {
    if (_projectFiles.length <= 1) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('At least one file is required.')),
        );
      }
      return;
    }

    final String fileName = _entityName(file);
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete File'),
          content: Text('Delete "$fileName"?'),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    if (_memoryMode) {
      final String projectName =
          _memorySelectedProject ?? _entityName(_selectedProject!);
      final Map<String, String>? files = _memoryWorkspace[projectName];
      if (files == null || !files.containsKey(fileName)) {
        return;
      }
      if (files.length <= 1) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('At least one file is required.')),
          );
        }
        return;
      }

      files.remove(fileName);
      if (_memorySelectedFile == fileName) {
        _memorySelectedFile = null;
      }
      await _reloadWorkspace(selectProjectName: projectName);
      return;
    }

    if (await file.exists()) {
      await file.delete();
    }
    await _reloadWorkspace(selectProjectName: _entityName(_selectedProject!));
  }

  Future<_NewFileRequest?> _showCreateFileDialog() async {
    String draftFileName = '';
    String selectedType = 'html';

    final _NewFileRequest? result = await showDialog<_NewFileRequest>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (
                BuildContext context,
                void Function(void Function()) setLocalState,
              ) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text('Add File'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.done,
                          onChanged: (String value) {
                            draftFileName = value;
                          },
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(
                              context,
                              _NewFileRequest(
                                baseName: value.trim(),
                                fileType: selectedType,
                              ),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'File name',
                            hintText: 'e.g. app or page-home',
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: selectedType,
                          decoration: const InputDecoration(
                            labelText: 'File type',
                          ),
                          items: const <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              value: 'html',
                              child: Text('HTML'),
                            ),
                            DropdownMenuItem(value: 'css', child: Text('CSS')),
                            DropdownMenuItem(
                              value: 'js',
                              child: Text('JavaScript'),
                            ),
                          ],
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            setLocalState(() {
                              selectedType = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Navigator.pop(
                                context,
                                _NewFileRequest(
                                  baseName: draftFileName.trim(),
                                  fileType: selectedType,
                                ),
                              );
                            },
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
        );
      },
    );
    return result;
  }

  String _sanitizeName(String raw) {
    return raw
        .replaceAll(RegExp(r'[<>:"/\\|?*\x00-\x1F]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .trim();
  }

  String _defaultHtmlTemplate() {
    return '<!DOCTYPE html>\n'
        '<html>\n'
        '<head>\n'
        '  <meta charset="UTF-8" />\n'
        '  <meta name="viewport" content="width=device-width, initial-scale=1.0" />\n'
        '  <title>Jay2xCoder Project</title>\n'
        '  <link rel="stylesheet" href="style.css" />\n'
        '</head>\n'
        '<body>\n'
        '  <h1>Hello Future Developer</h1>\n'
        '  <p>Build your project inside Jay2xCoder IDE.</p>\n'
        '  <script src="script.js"></script>\n'
        '</body>\n'
        '</html>\n';
  }

  String _defaultCssTemplate() {
    return 'body {\n'
        '  margin: 0;\n'
        '  font-family: Inter, sans-serif;\n'
        '  background: #0f172a;\n'
        '  color: #e2e8f0;\n'
        '}\n'
        '\n'
        'h1 {\n'
        '  color: #60a5fa;\n'
        '}\n';
  }

  String _defaultJsTemplate() {
    return 'const heading = document.querySelector("h1");\n'
        'if (heading) {\n'
        '  heading.addEventListener("click", () => {\n'
        '    console.log("Jay2xCoder IDE: heading clicked");\n'
        '  });\n'
        '}\n';
  }

  String _templateFor(String extension, String fileName) {
    switch (extension) {
      case 'html':
        return _defaultHtmlTemplate();
      case 'css':
        return _defaultCssTemplate();
      case 'js':
        return _defaultJsTemplate();
      default:
        return '// $fileName\n';
    }
  }

  Future<void> _toggleOrientationMode() async {
    if (_landscapeOnly) {
      await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _landscapeOnly = !_landscapeOnly;
    });
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/home');
  }

  Future<String> _composePreviewHtml() async {
    String html = _extension(_selectedFile?.path ?? '') == 'html'
        ? _editorController.text
        : '';
    String css = _extension(_selectedFile?.path ?? '') == 'css'
        ? _editorController.text
        : '';
    String js = _extension(_selectedFile?.path ?? '') == 'js'
        ? _editorController.text
        : '';

    if (_memoryMode) {
      final String projectName =
          _memorySelectedProject ?? _entityName(_selectedProject!);
      final Map<String, String> files =
          _memoryWorkspace[projectName] ?? <String, String>{};
      html = html.isNotEmpty
          ? html
          : (files['index.html'] ?? files.values.firstOrNull ?? '');
      css = css.isNotEmpty ? css : (files['style.css'] ?? '');
      js = js.isNotEmpty ? js : (files['script.js'] ?? '');
      return _injectAssets(html: html, css: css, js: js);
    }

    if (_selectedProject != null) {
      final List<FileSystemEntity> entities = _selectedProject!.listSync(
        followLinks: false,
      );
      final Map<String, File> byName = <String, File>{
        for (final File f in entities.whereType<File>()) _entityName(f): f,
      };
      if (html.isEmpty && byName['index.html'] != null) {
        html = await byName['index.html']!.readAsString();
      }
      if (css.isEmpty && byName['style.css'] != null) {
        css = await byName['style.css']!.readAsString();
      }
      if (js.isEmpty && byName['script.js'] != null) {
        js = await byName['script.js']!.readAsString();
      }
    }

    if (html.isEmpty) {
      html = _defaultHtmlTemplate();
    }
    return _injectAssets(html: html, css: css, js: js);
  }

  String _injectAssets({
    required String html,
    required String css,
    required String js,
  }) {
    String output = html;
    const String baseStyle = 'html, body { margin: 0; padding: 0; }';
    if (!output.toLowerCase().contains('<head')) {
      output = '<head></head>$output';
    }
    final String composedCss = css.isEmpty ? baseStyle : '$baseStyle\n$css';
    output = output.replaceFirst(
      RegExp('</head>', caseSensitive: false),
      '<style>\n$composedCss\n</style>\n</head>',
    );
    if (js.isNotEmpty) {
      if (output.toLowerCase().contains('</body>')) {
        output = output.replaceFirst(
          RegExp('</body>', caseSensitive: false),
          '<script>\n$js\n</script>\n</body>',
        );
      } else {
        output = '$output\n<script>\n$js\n</script>';
      }
    }
    return output;
  }

  Future<void> _runCode() async {
    await _saveCurrentFile(silent: true);
    final String previewHtml = await _composePreviewHtml();

    final List<LearningLevel> levels = ref.read(levelsProvider);
    final LessonItem? lesson = widget.lessonId == null
        ? null
        : findLessonById(levels, widget.lessonId!);
    if (lesson != null) {
      await ref
          .read(appStateControllerProvider.notifier)
          .markPracticeComplete(lesson.levelId);
    }

    final int runId = 1000 + Random().nextInt(9000);
    final String projectName = _selectedProject == null
        ? 'none'
        : _entityName(_selectedProject!);
    final String activeFile = _selectedFile == null
        ? 'none'
        : _entityName(_selectedFile!);

    if (!mounted) {
      return;
    }

    setState(() {
      _consoleText =
          '[Run #$runId]\n'
          'Workspace: Jay2xCoder Projects\n'
          'Project: $projectName\n'
          'Active file: $activeFile\n'
          'Status: Build successful. Opening full preview...';
    });

    await _openPreviewScreen(previewHtml);
  }

  Future<void> _openPreviewScreen(String html) async {
    if (!mounted) {
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return _IdePreviewOnlyScreen(html: html);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool landscape = orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFF06141C),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF0F2E3D),
              Color(0xFF0A1F2B),
              Color(0xFF07131C),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              children: <Widget>[
                _TopIdeBar(
                  saving: _saving,
                  onBack: _handleBack,
                  onSave: () => _saveCurrentFile(),
                  onRun: _runCode,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF60A5FA),
                          ),
                        )
                      : landscape
                      ? _buildLandscapeLayout()
                      : _buildPortraitLayout(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: _explorerOpen ? 230 : 56,
          child: _buildExplorerPanel(compact: !_explorerOpen),
        ),
        const SizedBox(width: 8),
        Expanded(child: _buildEditorPane()),
      ],
    );
  }

  Widget _buildPortraitLayout() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double editorHeight = max(540, constraints.maxHeight * 0.9);
        final double explorerHeight = min(210, constraints.maxHeight * 0.24);

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _explorerOpen = !_explorerOpen;
                      });
                    },
                    icon: Icon(
                      _explorerOpen ? Icons.folder_open : Icons.folder_outlined,
                    ),
                    label: Text(
                      _explorerOpen ? 'Hide Explorer' : 'Show Explorer',
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 240),
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      height: explorerHeight,
                      child: _buildExplorerPanel(),
                    ),
                  ),
                  crossFadeState: _explorerOpen
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
                SizedBox(height: editorHeight, child: _buildEditorPane()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExplorerPanel({bool compact = false}) {
    final String workspaceLabel = _workspaceRoot == null
        ? 'Jay2xCoder Projects'
        : _entityName(_workspaceRoot!);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1821),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x3A000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: compact
          ? _buildCompactExplorer()
          : _buildExpandedExplorer(workspaceLabel),
    );
  }

  Widget _buildCompactExplorer() {
    return Column(
      children: <Widget>[
        IconButton(
          tooltip: 'Expand explorer',
          onPressed: () {
            setState(() {
              _explorerOpen = true;
            });
          },
          icon: const Icon(Icons.chevron_right_rounded, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        IconButton(
          tooltip: 'Add project',
          onPressed: _createProject,
          icon: const Icon(
            Icons.create_new_folder_rounded,
            color: Colors.white70,
          ),
        ),
        IconButton(
          tooltip: 'Add file',
          onPressed: _createFile,
          icon: const Icon(Icons.note_add_rounded, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildExpandedExplorer(String workspaceLabel) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      LucideIcons.folderGit2,
                      size: 18,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        workspaceLabel,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Collapse explorer',
                      onPressed: () {
                        setState(() {
                          _explorerOpen = false;
                        });
                      },
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF102635),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Directory>(
                            value: _selectedProject,
                            isDense: true,
                            dropdownColor: const Color(0xFF102635),
                            iconEnabledColor: Colors.white70,
                            style: GoogleFonts.inter(color: Colors.white),
                            items: _projects.map((Directory project) {
                              return DropdownMenuItem<Directory>(
                                value: project,
                                child: Text(
                                  _entityName(project),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (Directory? value) {
                              if (value == null) {
                                return;
                              }
                              _switchProject(value);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'New project',
                        onPressed: _createProject,
                        icon: const Icon(
                          Icons.add_box_rounded,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Jay2xCoder Projects/${_selectedProject == null ? '' : _entityName(_selectedProject!)}',
                  style: GoogleFonts.firaCode(
                    color: const Color(0xFF88A8BA),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Text(
                      'Files',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Add file',
                      onPressed: _createFile,
                      icon: const Icon(
                        Icons.note_add_rounded,
                        color: Color(0xFF7DD3FC),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                ..._projectFiles.map((File file) {
                  final bool active = _selectedFile?.path == file.path;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: InkWell(
                      onTap: () => _openFile(file),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: active
                              ? const Color(0xFF114059)
                              : const Color(0x00114059),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              _iconForFile(file),
                              size: 18,
                              color: _colorForFile(file),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _entityName(file),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: active
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            PopupMenuButton<_FileAction>(
                              tooltip: 'File options',
                              color: const Color(0xFF102635),
                              icon: const Icon(
                                Icons.more_vert_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              onSelected: (_FileAction action) {
                                switch (action) {
                                  case _FileAction.rename:
                                    _renameFile(file);
                                    break;
                                  case _FileAction.delete:
                                    _deleteFile(file);
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return const <PopupMenuEntry<_FileAction>>[
                                  PopupMenuItem<_FileAction>(
                                    value: _FileAction.rename,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.edit_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Rename',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<_FileAction>(
                                    value: _FileAction.delete,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.delete_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditorPane() {
    final int lineCount = max(
      1,
      '\n'.allMatches(_editorController.text).length + 1,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool compact = constraints.maxHeight < 360;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0A1923),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x2F000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              _buildTabsBar(compact: compact),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: compact ? 36 : 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF08131B),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: ListView.builder(
                        controller: _lineNumbersScrollController,
                        padding: const EdgeInsets.only(top: 10, right: 6),
                        itemCount: lineCount,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: compact ? 20 : 22,
                            child: Text(
                              '${index + 1}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.firaCode(
                                color: const Color(0xFF4B738C),
                                fontSize: compact ? 10 : 11,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const VerticalDivider(width: 1, color: Colors.transparent),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          compact ? 12 : 16,
                          compact ? 8 : 12,
                          compact ? 12 : 16,
                          compact ? 8 : 12,
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                          ),
                          child: TextField(
                            controller: _editorController,
                            scrollController: _editorScrollController,
                            maxLines: null,
                            expands: true,
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFFD7E6F1),
                              fontSize: compact ? 13 : 15,
                              height: 1.45,
                            ),
                            cursorColor: const Color(0xFF60A5FA),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              isDense: true,
                              filled: false,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 2,
                              ),
                            ),
                            onChanged: (_) => _onEditorChanged(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildEditorFooter(compact: compact),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabsBar({required bool compact}) {
    return Container(
      height: compact ? 38 : 44,
      padding: EdgeInsets.fromLTRB(8, compact ? 4 : 7, 8, compact ? 4 : 6),
      decoration: const BoxDecoration(
        color: Color(0xFF0D2432),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _projectFiles.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final File file = _projectFiles[index];
          final bool active = _selectedFile?.path == file.path;
          return InkWell(
            onTap: () => _openFile(file),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF102E40)
                    : const Color(0xFF0A1A24),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Icon(
                    _iconForFile(file),
                    size: 15,
                    color: _colorForFile(file),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _entityName(file),
                    style: GoogleFonts.inter(
                      color: active ? Colors.white : const Color(0xFF9FB8C9),
                      fontSize: compact ? 11 : 13,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditorFooter({required bool compact}) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, compact ? 4 : 6, 10, compact ? 6 : 8),
      decoration: const BoxDecoration(
        color: Color(0xFF0B1A24),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  _selectedFile == null
                      ? 'No file selected'
                      : 'Editing: ${_entityName(_selectedFile!)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.firaCode(
                    color: const Color(0xFFA9C4D4),
                    fontSize: compact ? 10 : 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Rotate',
                visualDensity: compact ? VisualDensity.compact : null,
                onPressed: _toggleOrientationMode,
                icon: Icon(
                  Icons.screen_rotation_alt_rounded,
                  color: _landscapeOnly
                      ? const Color(0xFF7DD3FC)
                      : const Color(0xFFA9C4D4),
                ),
              ),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: compact ? 12 : 16,
                    vertical: compact ? 9 : 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _runCode,
                icon: Icon(Icons.code_rounded, size: compact ? 16 : 18),
                label: Text(
                  'Run Preview',
                  style: TextStyle(fontSize: compact ? 12 : 14),
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 4 : 8),
          InkWell(
            onTap: () {
              setState(() {
                _consoleOpen = !_consoleOpen;
              });
            },
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: <Widget>[
                Icon(
                  _consoleOpen
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_right_rounded,
                  color: const Color(0xFF8EB0C3),
                ),
                Text(
                  '<CONSOLE>',
                  style: GoogleFonts.firaCode(
                    color: const Color(0xFF8EB0C3),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 220),
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF06131D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _consoleText,
                style: GoogleFonts.firaCode(
                  color: const Color(0xFFA9C4D4),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
            crossFadeState: _consoleOpen && !compact
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }

  IconData _iconForFile(File file) {
    switch (_extension(file.path)) {
      case 'html':
        return Icons.description_rounded;
      case 'css':
        return Icons.style_rounded;
      case 'js':
        return Icons.javascript_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _colorForFile(File file) {
    switch (_extension(file.path)) {
      case 'html':
        return const Color(0xFFF97316);
      case 'css':
        return const Color(0xFF38BDF8);
      case 'js':
        return const Color(0xFFFACC15);
      default:
        return const Color(0xFFCBD5E1);
    }
  }
}

class _TopIdeBar extends StatelessWidget {
  const _TopIdeBar({
    required this.saving,
    required this.onBack,
    required this.onSave,
    required this.onRun,
  });

  final bool saving;
  final VoidCallback onBack;
  final VoidCallback onSave;
  final VoidCallback onRun;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF143346),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: 'Back',
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.flutter_dash_rounded,
            color: Color(0xFF60A5FA),
            size: 28,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Jay2xCoder IDE',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _RoundActionIcon(
            tooltip: 'Run',
            icon: Icons.play_arrow_rounded,
            background: const Color(0xFF163F2E),
            iconColor: const Color(0xFF86EFAC),
            onPressed: onRun,
          ),
          const SizedBox(width: 8),
          _RoundActionIcon(
            tooltip: saving ? 'Saving...' : 'Save',
            icon: saving ? Icons.hourglass_bottom_rounded : Icons.save_rounded,
            background: const Color(0xFF1A3648),
            iconColor: Colors.white70,
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}

class _IdePreviewOnlyScreen extends StatefulWidget {
  const _IdePreviewOnlyScreen({required this.html});

  final String html;

  @override
  State<_IdePreviewOnlyScreen> createState() => _IdePreviewOnlyScreenState();
}

class _IdePreviewOnlyScreenState extends State<_IdePreviewOnlyScreen> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0xFF07131C));
      _controller!.loadHtmlString(
        '${widget.html}\n<!-- preview:${DateTime.now().millisecondsSinceEpoch} -->',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06141C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF102737),
        foregroundColor: Colors.white,
        title: const Text('Preview Output'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: kIsWeb
                ? Container(
                    color: const Color(0xFF07131C),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: SelectableText(
                        widget.html,
                        style: GoogleFonts.firaCode(
                          color: const Color(0xFFA9C4D4),
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ),
                  )
                : _controller == null
                ? const Center(child: CircularProgressIndicator())
                : WebViewWidget(controller: _controller!),
          ),
        ),
      ),
    );
  }
}

class _RoundActionIcon extends StatelessWidget {
  const _RoundActionIcon({
    required this.tooltip,
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final Color background;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x30000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}

class _NewFileRequest {
  const _NewFileRequest({required this.baseName, required this.fileType});

  final String baseName;
  final String fileType;
}

enum _FileAction { rename, delete }

extension _FirstOrNullExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
