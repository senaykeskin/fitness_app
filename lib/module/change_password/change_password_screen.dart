import 'package:fitness_app/global/global_functions.dart';
import 'package:fitness_app/global/global_variables.dart';
import 'package:fitness_app/global/global_widgets.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Şifre Değiştir"),
      body: SafeArea(
          child: Padding(
        padding: top10 + horizontal15,
        child: Column(
          children: [
            InputWidget(
                isPassword: true,
                title: "Mevcut şifre",
                hintText: "******",
                isEmail: false),
            InputWidget(
                isPassword: true,
                title: "Yeni şifre",
                hintText: "******",
                isEmail: false),
            InputWidget(
                isPassword: true,
                title: "Yeni şifre (tekrar)",
                hintText: "******",
                isEmail: false),
            const Spacer(),
            signupAndLoginButton(
              context,
              "Kaydet",
              () {
                showSnackBar(context, "Şifre değiştirildi.");
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      )),
    );
  }
}
