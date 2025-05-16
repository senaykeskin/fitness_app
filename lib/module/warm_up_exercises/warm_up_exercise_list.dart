class WarmUpExercise {
  final String name;
  final String description;
  final int duration;
  final String animation;

  WarmUpExercise({
    required this.name,
    required this.description,
    required this.duration,
    required this.animation,
  });
}

final List<WarmUpExercise> warmUps = [
  WarmUpExercise(
    name: "Arm Circles",
    description: "Omuz ve kolları ısıtmak için birebir.",
    duration: 20,
    animation: "assets/animations/animation2.json",
  ),
  WarmUpExercise(
    name: "Jumping Jacks",
    description: "Tüm vücudu ısıtan klasik bir egzersiz.",
    duration: 30,
    animation: "assets/animations/jumping_jacks.json",
  ),
  WarmUpExercise(
    name: "High Knees",
    description: "Kalp atışını hızlandırır ve bacakları ısıtır.",
    duration: 30,
    animation: "assets/animations/animation2.json",
  ),
  WarmUpExercise(
    name: "Torso Twists",
    description: "Bel çevresini esnetmek için ideal.",
    duration: 20,
    animation: "assets/animations/animation2.json",
  ),
];
