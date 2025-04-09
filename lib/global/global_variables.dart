import 'dart:convert';

import 'package:flutter/material.dart';

import '../module/auth/index.dart';

final userData = {'userId': '12345'};
final BehaviorSubject<String> qrDataSubject =
    BehaviorSubject<String>.seeded(jsonEncode(userData));

final EdgeInsets top50 = EdgeInsets.only(top: 50);
final EdgeInsets top25 = EdgeInsets.only(top: 25);
final EdgeInsets top20 = EdgeInsets.only(top: 20);
final EdgeInsets top10 = EdgeInsets.only(top: 10);
final EdgeInsets bottom5 = EdgeInsets.only(bottom: 5);
final EdgeInsets bottom8 = EdgeInsets.only(bottom: 8);
final EdgeInsets bottom10 = EdgeInsets.only(bottom: 10);
final EdgeInsets bottom15 = EdgeInsets.only(bottom: 15);
final EdgeInsets bottom80 = EdgeInsets.only(bottom: 80);
final EdgeInsets all5 = EdgeInsets.all(5);
final EdgeInsets horizontal20 = EdgeInsets.symmetric(horizontal: 20);
final EdgeInsets horizontal10 = EdgeInsets.symmetric(horizontal: 10);
final EdgeInsets horizontal5 = EdgeInsets.symmetric(horizontal: 5);
final EdgeInsets vertical5 = EdgeInsets.symmetric(vertical: 5);
final EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: 8);
final EdgeInsets vertical10 = EdgeInsets.symmetric(vertical: 10);
final EdgeInsets vertical15 = EdgeInsets.symmetric(vertical: 15);

TextStyle kAxiforma24 = TextStyle(fontFamily: "Axiforma", fontSize: 24);
TextStyle kAxiforma18 = TextStyle(fontFamily: "Axiforma", fontSize: 18);
TextStyle kAntarctican20 = TextStyle(fontFamily: "Antarctican", fontSize: 20);
TextStyle kAntarctican17 = TextStyle(fontFamily: "Antarctican", fontSize: 17);
TextStyle kParalucent20 = TextStyle(fontFamily: "Paralucent", fontSize: 17);
TextStyle kAxiformaRegular17 =
    TextStyle(fontFamily: "AxiformaRegular", fontSize: 17);

final BorderRadius border10 = BorderRadius.all(Radius.circular(10));
final BorderRadius border15 = BorderRadius.all(Radius.circular(15));
final BorderRadius border25 = BorderRadius.circular(25);
final BorderRadius border30 = BorderRadius.circular(30);
final BorderRadius topBorder15 = BorderRadius.only(
    topLeft: Radius.circular(15), topRight: Radius.circular(15));

double W(BuildContext context) => MediaQuery.of(context).size.width;

double H(BuildContext context) => MediaQuery.of(context).size.height;
