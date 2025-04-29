class ProductModel {
  final String id;
  final String image;
  final String title;
  final String description;
  final double price;
  final String currency;

  ProductModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num).toDouble(),
      currency: map['currency'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'price': price,
      'currency': currency,
    };
  }
}

final List<ProductModel> productList = [
  ProductModel(
    id: "1",
    image: "assets/images/sports_towel.jpeg",
    title: "Spor Havlusu",
    description: "Ter emici, yumuşak mikrofiber havlu. "
        "Ter emici, yumuşak mikrofiber havlu. "
        "Ter emici, yumuşak mikrofiber havlu. "
        "Ter emici, yumuşak mikrofiber havlu.",
    price: 99.99,
    currency: "TL",
  ),
  ProductModel(
    id: "2",
    image: "assets/images/bottle.jpeg",
    title: "Su Matarası",
    description: "750ml BPA içermeyen spor matarası.",
    price: 59.90,
    currency: "TL",
  ),
  ProductModel(
    id: "3",
    image: "assets/images/yoga-mat.jpeg",
    title: "Yoga Matı",
    description: "Kaymaz tabanlı, 6mm kalınlıkta yoga matı.",
    price: 149.00,
    currency: "TL",
  ),
  ProductModel(
    id: "4",
    image: "assets/images/gloves.jpeg",
    title: "Ağırlık Eldiveni",
    description: "Ellerinize tam oturan, nefes alabilir eldiven.",
    price: 89.50,
    currency: "TL",
  ),
  ProductModel(
    id: "5",
    image: "assets/images/shaker.jpeg",
    title: "Protein Shaker",
    description: "Mikser topu ile 600ml protein karıştırıcı.",
    price: 69.00,
    currency: "TL",
  ),
  ProductModel(
    id: "6",
    image: "assets/images/jump-rope.jpeg",
    title: "Atlama İpi",
    description: "Ayarlanabilir uzunlukta, hızlı dönen ip.",
    price: 49.99,
    currency: "TL",
  ),
  ProductModel(
    id: "7",
    image: "assets/images/massage-ball.jpeg",
    title: "Masaj Topu",
    description: "Kas gevşetici, yoğun nokta masajı için top.",
    price: 39.90,
    currency: "TL",
  ),
  ProductModel(
    id: "8",
    image: "assets/images/foam-roller.jpeg",
    title: "Köpük Rulo",
    description: "Spor sonrası kas gevşetici silindir.",
    price: 119.00,
    currency: "TL",
  ),
  ProductModel(
    id: "9",
    image: "assets/images/headband.jpeg",
    title: "Ter Bandı",
    description: "Alın bölgesine uygun, yumuşak ter bandı.",
    price: 29.95,
    currency: "TL",
  ),
];
