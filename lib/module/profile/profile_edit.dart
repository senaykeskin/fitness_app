import 'index.dart';
import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  String gender = "Kadın";
  XFile? _image;

  @override
  void initState() {
    final profile = profileService.currentProfile;
    _ageController = TextEditingController(text: profile.age.toString());
    _heightController = TextEditingController(text: profile.height.toString());
    _weightController = TextEditingController(text: profile.weight.toString());
    gender = profile.gender;
    super.initState();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  void _saveChanges() {
    profileService.updateProfile(
      profileService.currentProfile.copyWith(
        age: int.tryParse(_ageController.text),
        height: int.tryParse(_heightController.text),
        weight: int.tryParse(_weightController.text),
        imagePath: _image?.path ?? profileService.currentProfile.imagePath,
      ),
    );
    showSnackBar(context, "Bilgiler güncellendi.");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Düzenle"),
      body: SingleChildScrollView(
        padding: horizontal10 + top20,
        child: Column(children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _image != null
                  ? FileImage(File(_image!.path))
                  : profileService.currentProfile.imagePath != null
                      ? FileImage(
                          File(profileService.currentProfile.imagePath!))
                      : null,
              child: _image == null &&
                      profileService.currentProfile.imagePath == null
                  ? const Icon(Icons.camera_alt, size: 32)
                  : null,
            ),
          ),
          const SizedBox(height: 24),
          profileTextInput("Yaş", _ageController),
          profileTextInput("Boy (cm)", _heightController),
          profileTextInput("Kilo (kg)", _weightController),
          profileDisableTextInput("Cinsiyet", gender),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _saveChanges,
            label: Text(
              "Kaydet",
              style: kAxiformaRegular17.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: GlobalConfig.primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: border15,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
