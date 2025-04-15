class GymEntryModel {
  final String gymName;
  final DateTime entryDateTime;
  final String location;
  final String entryMethod;

  GymEntryModel({
    required this.gymName,
    required this.entryDateTime,
    required this.location,
    required this.entryMethod,
  });
}

final List<GymEntryModel> pastGymEntries = [
  GymEntryModel(
    gymName: "FitLife Gym",
    entryDateTime: DateTime(2025, 4, 10, 18, 30),
    location: "Kadıköy, İstanbul",
    entryMethod: "QR Kod",
  ),
  GymEntryModel(
    gymName: "PowerZone Fitness",
    entryDateTime: DateTime(2025, 4, 8, 7, 45),
    location: "Beşiktaş, İstanbul",
    entryMethod: "Turnike",
  ),
  GymEntryModel(
    gymName: "Iron Temple Gym",
    entryDateTime: DateTime(2025, 4, 6, 19, 15),
    location: "Bakırköy, İstanbul",
    entryMethod: "Manuel Giriş",
  ),
  GymEntryModel(
    gymName: "Athletica Plus",
    entryDateTime: DateTime(2025, 4, 4, 17, 0),
    location: "Ataşehir, İstanbul",
    entryMethod: "QR Kod",
  ),
  GymEntryModel(
    gymName: "FitZone Studio",
    entryDateTime: DateTime(2025, 4, 2, 20, 30),
    location: "Şişli, İstanbul",
    entryMethod: "Turnike",
  ),
];

