import 'package:fitness_app/module/auth/login/index.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'global-config.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.isPassword,
    required this.title,
    required this.hintText,
    required this.isEmail,
  });

  final bool isPassword;
  final String title;
  final String hintText;
  final bool isEmail;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final BehaviorSubject<bool> _passwordVisibility =
      BehaviorSubject.seeded(true);

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
            style:
                kAxiformaRegular17.copyWith(fontSize: 15, color: Colors.black),
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
                        style: kAxiformaRegular17.copyWith(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textInputAction: TextInputAction.next,
                        obscureText: widget.isPassword ? snapshot.data! : false,
                        autofillHints: [AutofillHints.email],
                        keyboardType: widget.isEmail
                            ? TextInputType.emailAddress
                            : TextInputType.text,
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
                            borderSide:
                                BorderSide(width: 2, color: Colors.deepOrange),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: horizontal20 + vertical15,
                          hintText: widget.hintText,
                          hintStyle: kAxiformaRegular17.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
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

ElevatedButton signupAndLoginButton(
    BuildContext context, String text, VoidCallback navigation) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: GlobalConfig.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: border30),
          fixedSize: Size(W(context), 50)),
      onPressed: navigation,
      child: Text(
        text,
        style: kAxiformaRegular17.copyWith(color: Colors.black),
      ));
}

class RouteAnimation {
  static Route createRoute(Widget routePage, double dx, double dy,
      {Object? arguments}) {
    return PageRouteBuilder(
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionDuration: const Duration(milliseconds: 700),
      settings: RouteSettings(arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => routePage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(dx, dy);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}

Widget buildInfoRow(String title, String content) {
  return Padding(
    padding: vertical8,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: kAxiformaRegular17.copyWith(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        Expanded(
          child: Text(
            content,
            style: kAxiformaRegular17.copyWith(
                fontSize: 14, color: Colors.black54),
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: kAxiforma18.copyWith(color: Colors.white)),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    actions: [
      IconButton(
        icon: Icon(
          Icons.home,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            RouteAnimation.createRoute(
              CTabbar(),
              -1.0,
              0.0,
            ),
            (route) => false,
          );
        },
      ),
    ],
  );
}

Future<dynamic> productDetailBottomSheet(
    BuildContext context, Map<String, dynamic> item) {
  final BehaviorSubject<int> quantitySubject = BehaviorSubject<int>.seeded(1);

  return showModalBottomSheet(
    isDismissible: false,
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: bottom10 + horizontal10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.highlight_remove_rounded,
                    size: 30,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    quantitySubject.close();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  item["image"],
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"],
                        style: kAxiforma18.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        item["description"],
                        style: kAxiformaRegular17.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            StreamBuilder<int>(
              stream: quantitySubject.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                int quantity = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                          ),
                          icon: Icon(
                            Icons.remove_circle_outlined,
                            color: (quantity == 1)
                                ? Colors.grey.shade400
                                : GlobalConfig.primaryColor,
                            size: 30,
                          ),
                          onPressed: (quantity == 1)
                              ? null
                              : () {
                                  quantitySubject.add(quantity - 1);
                                },
                        ),
                        Text(
                          "$quantity",
                          style: kAxiformaRegular17.copyWith(fontSize: 16),
                        ),
                        IconButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                          ),
                          icon: Icon(
                            Icons.add_circle_outlined,
                            color: (quantity == 3)
                                ? Colors.grey.shade400
                                : GlobalConfig.primaryColor,
                            size: 30,
                          ),
                          onPressed: (quantity == 3)
                              ? null
                              : () {
                                  quantitySubject.add(quantity + 1);
                                },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        quantitySubject.close();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalConfig.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Sepete Ekle",
                        style: kAxiformaRegular17.copyWith(
                            fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
