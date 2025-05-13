import 'events_model.dart';

final List<EventsModel> myEvents = [
  EventsModel(
    title: 'HIIT Antrenman',
    date: DateTime(2025, 5, 14, 12, 00),
    image: 'assets/images/hiit.jpg',
    description:
        'Yüksek yoğunluklu interval antrenman (HIIT), kısa süreli ama yoğun'
        ' egzersizlerle maksimum yağ yakımını hedefler. '
        'Bu antrenman süresince kalp atış hızınızı yükselterek hem '
        'kardiyovasküler dayanıklılığınızı artırır hem de antrenmandan'
        ' sonra bile kalori yakımını sürdürür. Tüm seviyelere uygun olarak '
        'hazırlanan bu özel seans ile formda kal, enerjini yükselt ve '
        'antrenmanın keyfini çıkar!',
    location: 'Salon B - Cardio Bölgesi',
    trainerName: 'Baran Kaya',
    isMyEvent: true,
  ),
];
