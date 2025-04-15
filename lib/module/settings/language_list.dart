class LanguageOption {
  final String name;
  final String image;

  LanguageOption({required this.name, required this.image});
}

final List<LanguageOption> languageOptions = [
  LanguageOption(name: "Türkçe", image: "assets/images/turkey.png"),
  LanguageOption(name: "İngilizce", image: "assets/images/england.png"),
  LanguageOption(name: "Rusça", image: "assets/images/russia.png"),
];
