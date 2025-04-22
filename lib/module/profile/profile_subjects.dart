import 'package:rxdart/rxdart.dart';
import 'profile_model.dart';

class ProfileService {
  final _profileSubject = BehaviorSubject<ProfileModel>.seeded(
    ProfileModel(
        gender: "Kadın",
        age: 25,
        height: 165,
        weight: 55,
        imagePath: "assets/images/profile.png"),
  );

  Stream<ProfileModel> get profileStream => _profileSubject.stream;
  ProfileModel get currentProfile => _profileSubject.value;

  void updateProfile(ProfileModel updatedProfile) {
    _profileSubject.add(updatedProfile);
  }

  void dispose() {
    _profileSubject.close();
  }
}

final profileService = ProfileService();
