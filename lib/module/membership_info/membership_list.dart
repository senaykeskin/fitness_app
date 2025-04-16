class MembershipModel {
  final String name;
  final List<String> benefits;
  final DateTime validUntil;
  final String image;
  final String badge;
  final bool situation;
  final int price;

  MembershipModel(
      {required this.name,
      required this.benefits,
      required this.validUntil,
      required this.image,
      required this.badge,
      required this.situation,
      required this.price});
}

final List<MembershipModel> memberships = [
  MembershipModel(
      name: "Silver",
      benefits: [
        "Ücretsiz fitness danışmanlığı",
        "Haftada 5 gün spor salonu erişimi",
        "%5 spor takviyesi indirimi",
        "Aylık detaylı vücut analiz raporu",
        "Kilitli dolap kullanım hakkı",
        "Haftada 1 kez grup derslerine katılım",
      ],
      validUntil: DateTime(2025, 12, 31),
      image: 'assets/images/silver_card.png',
      badge: 'assets/images/silver.png',
      situation: true,
      price: 150),
  MembershipModel(
      name: "Gold",
      benefits: [
        "Sınırsız spor salonu erişimi",
        "Haftada 1 kişisel antrenör seansı",
        "Tüm ürünlerde %10 indirim",
        "Ücretsiz sporcu içeceği",
        "Grup derslerine sınırsız erişim",
        "Misafir davet hakkı (ayda 2 kez)",
      ],
      validUntil: DateTime(2026, 1, 31),
      image: 'assets/images/gold_card.png',
      badge: 'assets/images/gold.png',
      situation: false,
      price: 300
  ),
  MembershipModel(
      name: "Platinum",
      benefits: [
        "Sınırsız spor salonu ve sauna erişimi",
        "Haftalık sağlık ve vücut analizi",
        "Tüm ürünlerde %15 indirim ve sadakat puanı",
        "Öncelikli rezervasyon hakkı",
        "Ayda 2 kez kişisel antrenör seansı",
        "VIP soyunma odası erişimi",
        "Ücretsiz spor ekipmanı kiralama",
        "Aylık özel etkinlik daveti",
        "Misafir davet hakkı (ayda 3 kez)",
      ],
      validUntil: DateTime(2026, 6, 30),
      image: 'assets/images/platinum_card.png',
      badge: 'assets/images/platinum.png',
      situation: false,
      price: 500
  ),
];
