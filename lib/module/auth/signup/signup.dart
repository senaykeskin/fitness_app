import 'index.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CTabbar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputWidget(
                      isPassword: false,
                      title: "Ad Soyad",
                      hintText: "...",
                    ),
                    InputWidget(
                      isPassword: false,
                      title: "E-mail",
                      hintText: "example@gmail.com",
                    ),
                    InputWidget(
                      isPassword: true,
                      title: "Şifre",
                      hintText: "******",
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: horizontal10 + vertical15,
                width: double.infinity,
                child: signupAndLoginButton(
                    context, "Hesap Oluştur", _navigateToHome)),
          ],
        ),
      ),
    );
  }
}
