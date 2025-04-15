import 'package:fitness_app/global/global_widgets.dart';
import 'package:flutter/material.dart';
import '../body_analysis/body_analysis_screen.dart';
import '../settings/settings_screen.dart';

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
    onPressed: (context) {},
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
    title: 'Geçmiş Girişlerim',
    icon: Icons.history,
    onPressed: (context) {},
  ),
  ProfileMenuItem(
    title: 'Şifre Değiştir',
    icon: Icons.lock,
    onPressed: (context) {},
  ),
  ProfileMenuItem(
    title: 'Yardım & Destek',
    icon: Icons.help_outline,
    onPressed: (context) {},
  ),
  ProfileMenuItem(
    title: 'Hakkımızda',
    icon: Icons.info_outline,
    onPressed: (context) {},
  ),
  ProfileMenuItem(
    title: 'Çıkış Yap',
    icon: Icons.logout,
    onPressed: (context) {},
  ),
];
