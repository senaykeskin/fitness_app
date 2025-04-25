import 'package:flutter/material.dart';
import 'index.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  String gender = genderList[0];
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
    if (_ageController.text.isEmpty ||
        _heightController.text.isEmpty ||
        _weightController.text.isEmpty) {
      showSnackBar(context, "Lütfen tüm alanları doldurun.");
      return;
    }

    final updatedProfile = profileService.currentProfile.copyWith(
      age: int.tryParse(_ageController.text),
      height: int.tryParse(_heightController.text),
      weight: int.tryParse(_weightController.text),
      gender: gender,
      imagePath: _image?.path ?? profileService.currentProfile.imagePath,
    );

    profileService.updateProfile(updatedProfile);
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
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(File(_image!.path))
                      : controlImageFromPath(
                          profileService.currentProfile.imagePath),
                ),
                Positioned(
                  bottom: -5,
                  right: -5,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: all5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child:
                          const Icon(Icons.edit, size: 20, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          profileTextInput("Yaş", _ageController),
          profileTextInput("Boy (cm)", _heightController),
          profileTextInput("Kilo (kg)", _weightController),
          profileGenderDropdown(
            context: context,
            label: "Cinsiyet",
            selectedGender: gender,
            onChanged: (value) {
              setState(() {
                gender = value!;
              });
            },
          ),
          const SizedBox(height: 25),
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
              fixedSize: Size(W(context), 50),
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
