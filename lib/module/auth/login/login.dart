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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
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
                          style: kAxiformaRegular17.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: bottom10,
                        width: double.infinity,
                        child: signupAndLoginButton(
                            context, "Giriş Yap", navigateToHome),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
