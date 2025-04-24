import 'package:fitness_app/module/about_us/index.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Bildirimler"),
      body: Center(
        child: Text(
          "Bu sayfa yapım aşamasındadır!",
          style: kAxiformaRegular17.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}
