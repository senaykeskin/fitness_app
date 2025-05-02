import 'dart:convert';
import 'package:flutter/material.dart';
import '../module/profile/profile_subjects.dart';
import 'package:rxdart/rxdart.dart';
import 'global_config.dart';

final userData = {'userId': '12345'};
final BehaviorSubject<String> qrDataSubject =
    BehaviorSubject<String>.seeded(jsonEncode(userData));

final selectedLanguageSubject = BehaviorSubject<String>.seeded("Türkçe");

final bannerShown = BehaviorSubject<bool>.seeded(true);

final BehaviorSubject<Map<int, int>> waterSubject =
    BehaviorSubject<Map<int, int>>.seeded({});

final waterReminderSubject = BehaviorSubject<bool>.seeded(true);
final orderNotificationSubject = BehaviorSubject<bool>.seeded(true);
final workoutReminderSubject = BehaviorSubject<bool>.seeded(true);
final goalNotificationSubject = BehaviorSubject<bool>.seeded(true);
final campaignNotificationSubject = BehaviorSubject<bool>.seeded(true);
final announcementNotificationSubject = BehaviorSubject<bool>.seeded(true);

final List<String> genderList = ["Kadın", "Erkek"];

final EdgeInsets zero = EdgeInsets.zero;
final EdgeInsets top10 = EdgeInsets.only(top: 10);
final EdgeInsets top15 = EdgeInsets.only(top: 15);
final EdgeInsets top20 = EdgeInsets.only(top: 20);
final EdgeInsets top25 = EdgeInsets.only(top: 25);
final EdgeInsets top35 = EdgeInsets.only(top: 35);
final EdgeInsets top50 = EdgeInsets.only(top: 50);
final EdgeInsets top60 = EdgeInsets.only(top: 60);
final EdgeInsets bottom5 = EdgeInsets.only(bottom: 5);
final EdgeInsets bottom8 = EdgeInsets.only(bottom: 8);
final EdgeInsets bottom10 = EdgeInsets.only(bottom: 10);
final EdgeInsets bottom15 = EdgeInsets.only(bottom: 15);
final EdgeInsets bottom20 = EdgeInsets.only(bottom: 20);
final EdgeInsets bottom80 = EdgeInsets.only(bottom: 80);
final EdgeInsets all0 = EdgeInsets.all(0);
final EdgeInsets all1 = EdgeInsets.all(1);
final EdgeInsets all3 = EdgeInsets.all(3);
final EdgeInsets all5 = EdgeInsets.all(5);
final EdgeInsets all6 = EdgeInsets.all(6);
final EdgeInsets all10 = EdgeInsets.all(10);
final EdgeInsets all15 = EdgeInsets.all(15);
final EdgeInsets all20 = EdgeInsets.all(20);
final EdgeInsets horizontal5 = EdgeInsets.symmetric(horizontal: 5);
final EdgeInsets horizontal10 = EdgeInsets.symmetric(horizontal: 10);
final EdgeInsets horizontal15 = EdgeInsets.symmetric(horizontal: 15);
final EdgeInsets horizontal20 = EdgeInsets.symmetric(horizontal: 20);
final EdgeInsets horizontal40 = EdgeInsets.symmetric(horizontal: 40);
final EdgeInsets vertical5 = EdgeInsets.symmetric(vertical: 5);
final EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: 8);
final EdgeInsets vertical10 = EdgeInsets.symmetric(vertical: 10);
final EdgeInsets vertical15 = EdgeInsets.symmetric(vertical: 15);
final EdgeInsets vertical20 = EdgeInsets.symmetric(vertical: 20);

TextStyle kAxiforma24 = TextStyle(fontFamily: "Axiforma", fontSize: 24);
TextStyle kAxiforma18 = TextStyle(fontFamily: "Axiforma", fontSize: 18);
TextStyle kAntarctican20 = TextStyle(fontFamily: "Antarctican", fontSize: 20);
TextStyle kAntarctican17 = TextStyle(fontFamily: "Antarctican", fontSize: 17);
TextStyle kParalucent20 = TextStyle(fontFamily: "Paralucent", fontSize: 17);
TextStyle kAxiformaRegular17 =
    TextStyle(fontFamily: "AxiformaRegular", fontSize: 17);

final BorderRadius border10 = BorderRadius.all(Radius.circular(10));
final BorderRadius border15 = BorderRadius.all(Radius.circular(15));
final BorderRadius border20 = BorderRadius.all(Radius.circular(20));
final BorderRadius border25 = BorderRadius.circular(25);
final BorderRadius border30 = BorderRadius.circular(30);
final BorderRadius border100 = BorderRadius.circular(100);
final Radius radius25 = Radius.circular(25);
final BorderRadius verticalTop20 =
    BorderRadius.vertical(top: Radius.circular(20));
final BorderRadius verticalTop30 =
    BorderRadius.vertical(top: Radius.circular(30));
final BorderRadius topBorder15 = BorderRadius.only(
    topLeft: Radius.circular(15), topRight: Radius.circular(15));

double W(BuildContext context) => MediaQuery.of(context).size.width;

double H(BuildContext context) => MediaQuery.of(context).size.height;

final height = profileService.currentProfile.height;
final weight = profileService.currentProfile.weight;
final gender = profileService.currentProfile.gender;
final age = profileService.currentProfile.age;

double calculateBMI(double height, double weight) {
  final heightInMeters = height / 100;
  return weight / (heightInMeters * heightInMeters);
}

String getBMICategory(double bmi) {
  if (bmi < 18.5) return "Zayıf";
  if (bmi < 25) return "Normal";
  if (bmi < 30) return "Fazla Kilolu";
  return "Obez";
}

Color bmiColor(double bmi) {
  if (bmi < 18.5) return Colors.amber;
  if (bmi < 25) return GlobalConfig.primaryColor;
  if (bmi < 30) return Colors.orange;
  return Colors.red;
}

double calculateDailyWaterIntake(double weight) {
  return weight * 35;
}

double calculateDailyCalories(
    String gender, double height, double weight, int age) {
  if (gender == "Kadın") {
    return 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
  } else {
    return 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
  }
}
