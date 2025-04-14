import 'package:flutter/material.dart';
import 'global_variables.dart';

void showSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.black87}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 1300),
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
