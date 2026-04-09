import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jay2xcoder/core/constants/progression_utils.dart';
import 'package:jay2xcoder/data/models/learning_level.dart';
import 'package:jay2xcoder/data/models/lesson_item.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/providers/app_providers.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  final TextEditingController _htmlController = TextEditingController(
    text:
        '<!DOCTYPE html>\n<html>\n<head>\n  <title>Practice IDE</title>\n</head>\n<body>\n  <h1>Hello Future Developer</h1>\n  <p>Edit this HTML and run.</p>\n</body>\n</html>',
  );
  final TextEditingController _cssController = TextEditingController(
    text:
        'body {\n  font-family: Inter, sans-serif;\n  background: #f8fafc;\n  color: #1f2937;\n}\n\nh1 {\n  color: #4a90e2;\n}',
  );
  final TextEditingController _jsController = TextEditingController(
    text:
        'const msg = "Practice mode running";\nconsole.log(msg);\n\ndocument.querySelector("h1")?.addEventListener("click", () => {\n  alert("You clicked the heading!");\n});',
  );

  int _tabIndex = 0;
  bool _explorerOpen = true;
  bool _consoleOpen = false;
  String _consoleText = 'Console ready. Tap run to execute sample code.';

  @override
  void dispose() {
    _htmlController.dispose();
    _cssController.dispose();
    _jsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;

    final List<LearningLevel> levels = ref.watch(levelsProvider);
    final LessonItem? lesson = findLessonById(levels, widget.lessonId);

    if (lesson == null) {
      return const Scaffold(body: Center(child: Text('Lesson not found.')));
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const DevBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
              child: Column(
                children: <Widget>[
                  _TopBar(title: 'Practice IDE', onBack: () => context.pop()),
                  const SizedBox(height: 10),
                  _ExplorerPanel(
                    isOpen: _explorerOpen,
                    onToggle: () {
                      setState(() {
                        _explorerOpen = !_explorerOpen;
                      });
                    },
                    onSelectFile: (int index) {
                      setState(() {
                        _tabIndex = index;
                      });
                    },
                    selectedIndex: _tabIndex,
                  ),
                  const SizedBox(height: 10),
                  _FileTabs(
                    selectedIndex: _tabIndex,
                    onSelect: (int index) {
                      setState(() {
                        _tabIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _EditorPanel(
                      controller: _activeController,
                      dark: dark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ConsolePanel(
                    isOpen: _consoleOpen,
                    text: _consoleText,
                    onToggle: () {
                      setState(() {
                        _consoleOpen = !_consoleOpen;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _runPractice(lesson.levelId),
        backgroundColor: ReferencePalette.accentStart,
        foregroundColor: Colors.white,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }

  TextEditingController get _activeController {
    switch (_tabIndex) {
      case 1:
        return _cssController;
      case 2:
        return _jsController;
      case 0:
      default:
        return _htmlController;
    }
  }

  Future<void> _runPractice(String levelId) async {
    final int random = Random().nextInt(9999);
    await ref
        .read(appStateControllerProvider.notifier)
        .markPracticeComplete(levelId);

    setState(() {
      _consoleOpen = true;
      _consoleText =
          '[Run #$random]\nBuild successful.\nLoaded files: index.html, styles.css, app.js\nNo syntax errors found.';
    });
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ReferenceCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: ReferencePalette.onSurface(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.search)),
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.settings)),
        ],
      ),
    );
  }
}

class _ExplorerPanel extends StatelessWidget {
  const _ExplorerPanel({
    required this.isOpen,
    required this.onToggle,
    required this.onSelectFile,
    required this.selectedIndex,
  });

  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<int> onSelectFile;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<String> files = <String>['index.html', 'styles.css', 'app.js'];

    return ReferenceCard(
      color: ReferencePalette.surfaceSoft(context),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(14),
            child: Row(
              children: <Widget>[
                const Icon(LucideIcons.folderTree),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'File Explorer',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: ReferencePalette.onSurface(context),
                    ),
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: List<Widget>.generate(files.length, (int index) {
                  final bool selected = index == selectedIndex;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: InkWell(
                      onTap: () => onSelectFile(index),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? ReferencePalette.accentStart.withValues(
                                  alpha: 0.15,
                                )
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected
                                ? ReferencePalette.accentStart
                                : ReferencePalette.cardBorder(context),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              selected
                                  ? Icons.insert_drive_file_rounded
                                  : Icons.description_outlined,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              files[index],
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: ReferencePalette.onSurface(context),
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            crossFadeState: isOpen
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 260),
          ),
        ],
      ),
    );
  }
}

class _FileTabs extends StatelessWidget {
  const _FileTabs({required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['index.html', 'styles.css', 'app.js'];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final bool selected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: selected
                    ? ReferencePalette.accentStart.withValues(alpha: 0.2)
                    : ReferencePalette.surfaceSoft(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? ReferencePalette.accentStart
                      : ReferencePalette.cardBorder(context),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                tabs[index],
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: selected
                      ? ReferencePalette.accentStart
                      : ReferencePalette.onMuted(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemCount: tabs.length,
      ),
    );
  }
}

class _EditorPanel extends StatelessWidget {
  const _EditorPanel({required this.controller, required this.dark});

  final TextEditingController controller;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return ReferenceCard(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 32,
            child: _LineNumbers(lineCount: controller.text.split('\n').length),
          ),
          const VerticalDivider(color: Color(0xFF334155), width: 1),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              style: GoogleFonts.firaCode(
                color: const Color(0xFFE2E8F0),
                fontSize: 13,
                height: 1.45,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.transparent,
                filled: false,
                isDense: true,
              ),
              cursorColor: ReferencePalette.accentStart,
            ),
          ),
        ],
      ),
    );
  }
}

class _LineNumbers extends StatelessWidget {
  const _LineNumbers({required this.lineCount});

  final int lineCount;

  @override
  Widget build(BuildContext context) {
    final int safeCount = max(1, min(400, lineCount));

    return ListView.builder(
      itemCount: safeCount,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.5),
          child: Text(
            '${index + 1}',
            textAlign: TextAlign.right,
            style: GoogleFonts.firaCode(
              color: const Color(0xFF64748B),
              fontSize: 11,
            ),
          ),
        );
      },
    );
  }
}

class _ConsolePanel extends StatelessWidget {
  const _ConsolePanel({
    required this.isOpen,
    required this.text,
    required this.onToggle,
  });

  final bool isOpen;
  final String text;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return ReferenceCard(
      color: ReferencePalette.surfaceSoft(context),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: <Widget>[
                const Icon(LucideIcons.terminal),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Output Console',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ReferencePalette.onSurface(context),
                    ),
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 260),
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: GoogleFonts.firaCode(
                  color: const Color(0xFF94A3B8),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
            crossFadeState: isOpen
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
