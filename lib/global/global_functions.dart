import 'dart:io';
import 'package:fitness_app/global/global_widgets.dart';
import 'package:fitness_app/module/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../module/settings/language_list.dart';
import '../module/widgets/c_tab_bar.dart';

String formatDateTime(DateTime dateTime) {
  final timeFormat = DateFormat.Hm('tr_TR');
  final dateFormat = DateFormat('d MMMM y', 'tr_TR');
  return '${dateFormat.format(dateTime)}\n${timeFormat.format(dateTime)}';
}

String formatDateTimeHorizontal(DateTime dateTime) {
  final timeFormat = DateFormat.Hm('tr_TR');
  final dateFormat = DateFormat('d MMMM y', 'tr_TR');
  return '${dateFormat.format(dateTime)} - ${timeFormat.format(dateTime)}';
}

void showSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.black87}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(message,
          style:
              kAxiformaRegular17.copyWith(fontSize: 15, color: Colors.white)),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: border15,
      ),
    ),
  );
}

ImageProvider? controlImageFromPath(String? path) {
  if (path == null) return null;
  if (path.startsWith("assets/")) {
    return AssetImage(path);
  } else {
    return FileImage(File(path));
  }
}

Future<dynamic> languageBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: verticalTop20,
    ),
    builder: (context) {
      String selectedLanguage = selectedLanguageSubject.value;

      return StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: all15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...languageOptions.map((langOption) {
                bool isSelected = selectedLanguage == langOption.name;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = langOption.name;
                    });
                    selectedLanguageSubject.add(langOption.name);

                    Navigator.of(context).pushAndRemoveUntil(
                      RouteAnimation.createRoute(
                        CTabbar(showAnimation: true),
                        -1.0,
                        0.0,
                      ), (route) => false,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: vertical5,
                    padding: all15,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? GlobalConfig.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: border15,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          langOption.image,
                          width: 40,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          langOption.name,
                          style: kAxiformaRegular17.copyWith(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}
