import 'package:flutter/material.dart';
import 'index.dart';

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final void Function(BuildContext context) onPressed;

  ProfileMenuItem({
    required this.title,
    required this.icon,
    required this.onPressed,
  });
}

final List<ProfileMenuItem> profileMenuItems = [
  ProfileMenuItem(
    title: 'Üyelik Bilgileri',
    icon: Icons.person,
    onPressed: (context) {
      Navigator.push(context,
          RouteAnimation.createRoute(MembershipInformationScreen(), 1.0, 0.0));
    },
  ),
  ProfileMenuItem(
    title: 'Bildirimler',
    icon: Icons.notifications,
    onPressed: (context) {},
  ),
  ProfileMenuItem(
    title: 'Vücut Analizi',
    icon: Icons.accessibility_new,
    onPressed: (context) {
      Navigator.push(
          context, RouteAnimation.createRoute(BodyAnalysisScreen(), 1.0, 0.0));
    },
  ),
  ProfileMenuItem(
    title: 'Ayarlar',
    icon: Icons.settings,
    onPressed: (context) {
      Navigator.push(
          context, RouteAnimation.createRoute(SettingsScreen(), 1.0, 0.0));
    },
  ),
  ProfileMenuItem(
    title: 'Geçmiş Salon Girişleri',
    icon: Icons.history,
    onPressed: (context) {
      Navigator.push(
          context, RouteAnimation.createRoute(LoginHistoryScreen(), 1.0, 0.0));
    },
  ),
  ProfileMenuItem(
    title: 'Şifre Değiştir',
    icon: Icons.lock,
    onPressed: (context) {
      Navigator.push(context,
          RouteAnimation.createRoute(ChangePasswordScreen(), 1.0, 0.0));
    },
  ),
  ProfileMenuItem(
    title: 'Yardım & Destek',
    icon: Icons.help_rounded,
    onPressed: (context) {
      Navigator.push(context,
          RouteAnimation.createRoute(HelpAndSupportScreen(), 1.0, 0.0));
    },
  ),
  ProfileMenuItem(
    title: 'Hakkımızda',
    icon: Icons.info_rounded,
    onPressed: (context) {
      Navigator.push(
          context, RouteAnimation.createRoute(AboutUsScreen(), 1.0, 0.0));
    },
  ),
  ProfileMenuItem(
    title: 'Çıkış Yap',
    icon: Icons.logout,
    onPressed: (context) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(color: GlobalConfig.primaryColor),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();
      Navigator.push(
        context,
        RouteAnimation.createRoute(WelcomeScreen(), 1.0, 0.0),
      );
    },
  ),
];
