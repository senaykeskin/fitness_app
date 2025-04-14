class ProfileModel {
  final String gender;
  final String? imagePath;
  final int age;
  final int height;
  final int weight;

  ProfileModel({
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    this.imagePath,
  });

  ProfileModel copyWith({
    String? gender,
    String? imagePath,
    int? age,
    int? height,
    int? weight,
  }) {
    return ProfileModel(
      gender: gender ?? this.gender,
      imagePath: imagePath ?? this.imagePath,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}
