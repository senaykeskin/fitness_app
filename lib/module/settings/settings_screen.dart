import 'package:fitness_app/global/global_variables.dart';
import 'package:fitness_app/global/global_widgets.dart';
import 'package:flutter/material.dart';
import '../../global/global_functions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Ayarlar"),
      body: SafeArea(
          child: Padding(
        padding: horizontal10,
        child: Column(
          children: [
            SettingsButton(
              leadingIcon: Icons.language_outlined,
              iconColor: Colors.blueAccent,
              text: "Dil",
                onPress: () {
                  languageBottomSheet(context);
                }
            ),
            SettingsButton(
                leadingIcon: Icons.nightlight_round,
                iconColor: Colors.black,
                text: "Karanlık mod",
                onPress: () {})
          ],
        ),
      )),
    );
  }
}
