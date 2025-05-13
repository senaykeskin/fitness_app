import 'events_model.dart';

final List<EventsModel> upcomingEvents = [
  EventsModel(
    title: 'Yoga Sınıfı',
    date: DateTime(2025, 5, 23, 15, 30),
    image: 'assets/images/yoga_class.jpg',
    description:
        'Gevşeme ve denge odaklı bu yoga sınıfı, bedeninizi ve zihninizi '
        'rahatlatmak için özel olarak tasarlandı. Nefes çalışmaları,'
        ' esneme hareketleri ve odaklanma teknikleriyle hem fiziksel '
        'esnekliğinizi artıracak hem de zihinsel dinginliğe ulaşacaksınız.'
        ' Her seviyeye uygun olarak hazırlanan bu seans, günlük stresinizi '
        'azaltmak ve içsel huzura ulaşmak için ideal bir fırsat sunuyor.',
    location: 'Salon A - Yoga Alanı',
    trainerName: 'Melis Yılmaz',
    isMyEvent: false,
  ),
  EventsModel(
    title: 'HIIT Antrenman',
    date: DateTime(2025, 5, 26, 12, 00),
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
  EventsModel(
    title: 'Pilates',
    date: DateTime(2025, 5, 28, 15, 00),
    image: 'assets/images/pilates.jpg',
    description:
        'Esnekliğini ve core kuvvetini artırmak istiyorsan bu pilates sınıfı'
        ' tam sana göre. Kontrollü nefes teknikleriyle yapılan egzersizler,'
        ' duruşunu düzeltmeye, kaslarını güçlendirmeye ve beden farkındalığını '
        'artırmaya yardımcı olur. Mat üzerinde gerçekleştirilen bu seans, '
        'her seviyeye uygun hareketlerle hem zihinsel hem fiziksel bir '
        'yenilenme sağlar. Düzenli katılımla vücut postüründe gözle görülür'
        ' gelişmeler fark edeceksin.',
    location: 'Salon C - Pilates Stüdyosu',
    trainerName: 'Deniz Karaca',
    isMyEvent: false,
  ),
];
