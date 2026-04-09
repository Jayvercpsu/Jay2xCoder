import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jay2xcoder/core/extensions/l10n_extension.dart';
import 'package:jay2xcoder/data/models/code_practice_template.dart';
import 'package:jay2xcoder/presentation/shared/widgets/code_editor_card.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/soft_card.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodingPlaygroundScreen extends StatefulWidget {
  const CodingPlaygroundScreen({
    super.key,
    required this.template,
    required this.lessonTitle,
    this.lessonId,
  });

  final CodePracticeTemplate template;
  final String lessonTitle;
  final String? lessonId;

  @override
  State<CodingPlaygroundScreen> createState() => _CodingPlaygroundScreenState();
}

class _CodingPlaygroundScreenState extends State<CodingPlaygroundScreen> {
  late final TextEditingController _htmlController;
  late final TextEditingController _cssController;
  late final TextEditingController _jsController;

  late final WebViewController _webViewController;
  int _previewVersion = 0;

  @override
  void initState() {
    super.initState();
    _htmlController = TextEditingController(text: widget.template.starterHtml);
    _cssController = TextEditingController(text: widget.template.starterCss);
    _jsController = TextEditingController(text: widget.template.starterJs);

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runCode();
      Future<void>.delayed(const Duration(milliseconds: 180), _runCode);
    });
  }

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
    final l10n = context.l10n;

    final List<_CodeTabConfig> tabs = <_CodeTabConfig>[
      _CodeTabConfig(
        label: l10n.playgroundHtmlTab,
        controller: _htmlController,
      ),
      if (widget.template.enableCssTab)
        _CodeTabConfig(
          label: l10n.playgroundCssTab,
          controller: _cssController,
        ),
      if (widget.template.enableJsTab)
        _CodeTabConfig(label: l10n.playgroundJsTab, controller: _jsController),
    ];

    final bool hasMultipleTabs = tabs.length > 1;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.playgroundTitle(widget.lessonTitle))),
        body: Stack(
          children: <Widget>[
            const DevBackground(),
            SafeArea(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double width = constraints.maxWidth;
                  final double viewportHeight = constraints.maxHeight;
                  final double editorHeight = (viewportHeight * 0.36).clamp(
                    210.0,
                    320.0,
                  );
                  final double previewHeight = (viewportHeight * 0.34).clamp(
                    220.0,
                    360.0,
                  );

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SoftCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                l10n.playgroundIntro,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.playgroundStarterHint,
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (width >= 880)
                          SizedBox(
                            height: 460,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: hasMultipleTabs
                                      ? Column(
                                          children: <Widget>[
                                            TabBar(
                                              isScrollable: true,
                                              onTap: (_) {},
                                              tabs: tabs
                                                  .map(
                                                    (_CodeTabConfig tab) =>
                                                        Tab(text: tab.label),
                                                  )
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: TabBarView(
                                                children: tabs
                                                    .map(
                                                      (_CodeTabConfig tab) =>
                                                          CodeEditorCard(
                                                            controller:
                                                                tab.controller,
                                                            languageLabel:
                                                                tab.label,
                                                          ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        )
                                      : CodeEditorCard(
                                          controller: tabs.first.controller,
                                          languageLabel: tabs.first.label,
                                        ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _PreviewPane(
                                    l10nOutputLabel:
                                        l10n.playgroundOutputPreview,
                                    theme: theme,
                                    controller: _webViewController,
                                    previewVersion: _previewVersion,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else ...<Widget>[
                          if (hasMultipleTabs) ...<Widget>[
                            TabBar(
                              isScrollable: true,
                              onTap: (_) {},
                              tabs: tabs
                                  .map(
                                    (_CodeTabConfig tab) =>
                                        Tab(text: tab.label),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: editorHeight,
                              child: TabBarView(
                                children: tabs
                                    .map(
                                      (_CodeTabConfig tab) => CodeEditorCard(
                                        controller: tab.controller,
                                        languageLabel: tab.label,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ] else
                            SizedBox(
                              height: editorHeight,
                              child: CodeEditorCard(
                                controller: tabs.first.controller,
                                languageLabel: tabs.first.label,
                              ),
                            ),
                        ],
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: _runCode,
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: Text(l10n.playgroundRun),
                            ),
                            OutlinedButton.icon(
                              onPressed: _reloadCode,
                              icon: const Icon(Icons.refresh_rounded),
                              label: Text(l10n.playgroundReload),
                            ),
                            OutlinedButton.icon(
                              onPressed: _restartCode,
                              icon: const Icon(Icons.restart_alt_rounded),
                              label: Text(l10n.playgroundRestart),
                            ),
                            if (widget.lessonId != null)
                              OutlinedButton.icon(
                                onPressed: () => context.push(
                                  '/lesson/${widget.lessonId}/quiz',
                                ),
                                icon: const Icon(Icons.quiz_outlined),
                                label: Text(l10n.lessonTakeQuiz),
                              ),
                          ],
                        ),
                        if (width < 880) ...<Widget>[
                          const SizedBox(height: 12),
                          _PreviewPane(
                            l10nOutputLabel: l10n.playgroundOutputPreview,
                            theme: theme,
                            controller: _webViewController,
                            previewVersion: _previewVersion,
                            height: previewHeight,
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _runCode() async {
    final String html =
        '${_composeDocument()}\n<!-- preview:${DateTime.now().millisecondsSinceEpoch} -->';
    await _webViewController.loadHtmlString(html);
    if (mounted) {
      setState(() {
        _previewVersion += 1;
      });
    }
  }

  Future<void> _reloadCode() async {
    await _runCode();
  }

  Future<void> _restartCode() async {
    _htmlController.text = widget.template.starterHtml;
    _cssController.text = widget.template.starterCss;
    _jsController.text = widget.template.starterJs;

    await _runCode();
  }

  String _composeDocument() {
    final String htmlInput = _htmlController.text.trim();
    final String cssInput = _cssController.text.trim();
    final String jsInput = _jsController.text.trim();

    if (_looksLikeFullDocument(htmlInput)) {
      return _injectCssAndJs(htmlInput, css: cssInput, js: jsInput);
    }

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
$cssInput
  </style>
</head>
<body>
$htmlInput
  <script>
$jsInput
  </script>
</body>
</html>
''';
  }

  bool _looksLikeFullDocument(String code) {
    final String lower = code.toLowerCase();
    return lower.contains('<html') ||
        lower.contains('<head') ||
        lower.contains('<body');
  }

  String _injectCssAndJs(
    String document, {
    required String css,
    required String js,
  }) {
    String updated = document;

    if (css.isNotEmpty) {
      final String styleBlock = '<style>\n$css\n</style>';
      if (updated.toLowerCase().contains('</head>')) {
        updated = updated.replaceFirst(
          RegExp('</head>', caseSensitive: false),
          '$styleBlock</head>',
        );
      } else {
        updated = '$styleBlock\n$updated';
      }
    }

    if (js.isNotEmpty) {
      final String scriptBlock = '<script>\n$js\n</script>';
      if (updated.toLowerCase().contains('</body>')) {
        updated = updated.replaceFirst(
          RegExp('</body>', caseSensitive: false),
          '$scriptBlock</body>',
        );
      } else {
        updated = '$updated\n$scriptBlock';
      }
    }

    return updated;
  }
}

class _CodeTabConfig {
  const _CodeTabConfig({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;
}

class _PreviewPane extends StatelessWidget {
  const _PreviewPane({
    required this.l10nOutputLabel,
    required this.theme,
    required this.controller,
    required this.previewVersion,
    this.height = 280,
  });

  final String l10nOutputLabel;
  final ThemeData theme;
  final WebViewController controller;
  final int previewVersion;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10nOutputLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.25),
                ),
              ),
              child: WebViewWidget(
                key: ValueKey<int>(previewVersion),
                controller: controller,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
