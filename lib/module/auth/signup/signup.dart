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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputWidget(
                isPassword: false,
                title: "Ad Soyad",
                hintText: "...",
                isEmail: false,
              ),
              InputWidget(
                isPassword: false,
                title: "E-mail",
                hintText: "example@gmail.com",
                isEmail: true,
              ),
              InputWidget(
                isPassword: true,
                title: "Şifre",
                hintText: "******",
                isEmail: false,
              ),
              InputWidget(
                isPassword: true,
                title: "Şifre (tekrar)",
                hintText: "******",
                isEmail: false,
              ),
              const SizedBox(height: 10),
              Container(
                margin: bottom10,
                child: signupAndLoginButton(
                  context,
                  "Hesap Oluştur",
                  _navigateToHome,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
