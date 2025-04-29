import 'package:flutter/material.dart';
import 'index.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: StreamBuilder<ProfileModel>(
          stream: profileService.profileStream,
          initialData: profileService.currentProfile,
          builder: (context, snapshot) {
            final profile = snapshot.data!;
            return Padding(
              padding: top20 + horizontal10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: top60,
                          padding: top60 + bottom20,
                          width: W(context),
                          decoration: BoxDecoration(
                            color: GlobalConfig.primaryColor,
                            borderRadius: border15,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Text(
                                'Şenay Keskin',
                                style: kAxiformaRegular17.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InfoItem(
                                      title: profile.age.toString(),
                                      subtitle: 'Yaş'),
                                  InfoItem(
                                      title: profile.gender,
                                      subtitle: 'Cinsiyet'),
                                  InfoItem(
                                      title: profile.height.toString(),
                                      subtitle: 'Boy'),
                                  InfoItem(
                                      title: profile.weight.toString(),
                                      subtitle: 'Kilo'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            padding: all3,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: border100,
                            ),
                            child: ClipRRect(
                              borderRadius: border100,
                              child: Image(
                                image:
                                    controlImageFromPath(profile.imagePath) ??
                                        const AssetImage(
                                            "assets/images/profile.png"),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          right: 5,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                RouteAnimation.createRoute(
                                    ProfileEdit(), 1.0, 0.0),
                              );
                            },
                            icon: const Icon(Icons.edit,
                                size: 25, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...profileMenuItems.map((item) {
                      return Padding(
                        padding: bottom10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: zero,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.grey, width: 1.5),
                              borderRadius: border15,
                            ),
                          ),
                          onPressed: () => item.onPressed(context),
                          child: ListTile(
                            contentPadding: horizontal15,
                            leading: Icon(item.icon,
                                color: GlobalConfig.primaryColor, size: 25),
                            title: Text(item.title),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
