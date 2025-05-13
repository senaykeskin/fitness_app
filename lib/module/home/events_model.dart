class EventsModel {
  final String title;
  final String image;
  final String location;
  final String trainerName;
  final String description;
  final bool isMyEvent;
  final DateTime date;

  EventsModel({
    required this.title,
    required this.image,
    required this.location,
    required this.trainerName,
    required this.description,
    required this.isMyEvent,
    required this.date,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventsModel && other.title == title && other.date == date;
  }

  @override
  int get hashCode => title.hashCode ^ date.hashCode;
}
