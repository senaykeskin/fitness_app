class Streak {
  final int days;
  final DateTime start;
  final DateTime end;

  Streak({required this.days, required this.start, required this.end});
}

final dummyStreakData = [
  Streak(days: 17, start: DateTime(2025, 4, 10), end: DateTime(2025, 4, 26)),
  Streak(days: 5, start: DateTime(2025, 4, 3), end: DateTime(2025, 4, 7)),
  Streak(days: 3, start: DateTime(2025, 3, 28), end: DateTime(2025, 3, 30)),
  Streak(days: 6, start: DateTime(2025, 3, 20), end: DateTime(2025, 3, 25)),
  Streak(days: 4, start: DateTime(2025, 2, 15), end: DateTime(2025, 3, 18)),
  Streak(days: 6, start: DateTime(2025, 1, 20), end: DateTime(2025, 3, 25)),
];
