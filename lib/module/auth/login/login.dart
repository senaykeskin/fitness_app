import 'index.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToHome() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CTabbar()),
      );
    }

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
                    TextButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Şifremi unuttum",
                        style: kAntarctican17.copyWith(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: horizontal10 + vertical15,
              width: double.infinity,
              child: signupAndLoginButton(context, "Giriş Yap", navigateToHome),
            ),
          ],
        ),
      ),
    );
  }
}
