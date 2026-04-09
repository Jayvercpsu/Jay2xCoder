enum PracticeLanguage { html, css, javascript, framework }

class CodePracticeTemplate {
  const CodePracticeTemplate({
    required this.lessonId,
    required this.language,
    required this.sampleCode,
    required this.starterHtml,
    required this.starterCss,
    required this.starterJs,
    required this.expectedOutputFallback,
    this.enableCssTab = false,
    this.enableJsTab = false,
  });

  final String lessonId;
  final PracticeLanguage language;
  final String sampleCode;
  final String starterHtml;
  final String starterCss;
  final String starterJs;
  final String expectedOutputFallback;
  final bool enableCssTab;
  final bool enableJsTab;
}
