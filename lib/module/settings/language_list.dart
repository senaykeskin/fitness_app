class LanguageOption {
  final String name;
  final String assetPath;

  LanguageOption({required this.name, required this.assetPath});
}

final List<LanguageOption> languageOptions = [
  LanguageOption(name: "Türkçe", assetPath: "assets/images/turkey.png"),
  LanguageOption(name: "İngilizce", assetPath: "assets/images/england.png"),
  LanguageOption(name: "Rusça", assetPath: "assets/images/russia.png"),
];
