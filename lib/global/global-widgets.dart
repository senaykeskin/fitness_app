import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'global-config.dart';
import 'global-variables.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.isPassword,
    required this.title,
    required this.hintText,
  });

  final bool isPassword;
  final String title;
  final String hintText;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final BehaviorSubject<bool> _passwordVisibility = BehaviorSubject.seeded(true);

  @override
  void dispose() {
    _passwordVisibility.close();
    super.dispose();
  }

  void _changeVisibility() {
    _passwordVisibility.add(!_passwordVisibility.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: top20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: border15,
            ),
            margin: top10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: StreamBuilder<bool>(
                    stream: _passwordVisibility.stream,
                    initialData: _passwordVisibility.value,
                    builder: (context, snapshot) {
                      return TextField(
                        obscureText: widget.isPassword ? snapshot.data! : false,
                        autofillHints: [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: border25,
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: border25,
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: border25,
                            borderSide: BorderSide(width: 2, color: Colors.blue),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: horizontal20 + vertical15,
                          hintText: widget.hintText,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                          suffixIcon: widget.isPassword
                              ? IconButton(
                            onPressed: _changeVisibility,
                            icon: Icon(
                              snapshot.data!
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


ElevatedButton signupAndLoginButton(BuildContext context, String text) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: GlobalConfig.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: border30),
          fixedSize: Size(W(context), 50)),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 17),
      ));
}
