import 'events_model.dart';

final List<EventsModel> specialEvents = [
  EventsModel(
      title: 'Omuz & Sırt',
      date: DateTime(2025, 5, 19, 12, 00),
      image: 'assets/images/shoulder_event.jpg',
      description:
          'Bu özel antrenman programında omuz ve sırt kaslarını hedefleyen egzersizler yapılacaktır. '
          'Dumbbell shoulder press, lateral raise, bent-over row gibi hareketlerle kaslarınızı geliştirirken, '
          'duruşunuzu düzeltmeye ve postürünüzü iyileştirmeye yardımcı olacağız. Tüm seviyelere uygundur ve '
          'kişisel antrenör desteğiyle gerçekleştirilir.',
      location: 'Stüdyo 2 - Zemin Kat',
      trainerName: 'Antrenör Mert Yıldız',
      isMyEvent: false),
  EventsModel(
      title: 'Bacak Antrenmanı',
      date: DateTime(2025, 5, 20, 12, 00),
      image: 'assets/images/leg_events.jpg',
      description:
          'Bu yoğun tempolu bacak antrenmanında squat, lunge, leg press ve calf raise gibi hareketlerle alt vücut kaslarınızı zorlayacaksınız. '
          'Hem güç kazanımı hem de dayanıklılığı artırmayı hedefleyen bu antrenman, özellikle kas kütlesini artırmak isteyenler için idealdir. '
          'Antrenman öncesi kısa bir ısınma ve sonrası esneme seansı da programdadır.',
      location: 'Fonksiyonel Alan - 1. Kat',
      trainerName: 'Antrenör Ayşe Demir',
      isMyEvent: false),
];
