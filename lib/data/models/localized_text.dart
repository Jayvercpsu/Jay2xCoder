class LocalizedText {
  const LocalizedText({required this.en, String? ceb, String? fil})
    : ceb = ceb ?? en,
      fil = fil ?? en;

  final String en;
  final String ceb;
  final String fil;

  String resolve(String localeCode) {
    switch (localeCode.trim().toLowerCase()) {
      case 'ceb':
        return ceb;
      case 'fil':
        return fil;
      case 'en':
      default:
        return en;
    }
  }
}
