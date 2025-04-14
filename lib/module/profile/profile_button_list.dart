import 'package:flutter/material.dart';

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

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
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Bildirimler',
    icon: Icons.notifications,
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Vücut Analizi',
    icon: Icons.accessibility_new,
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Ayarlar',
    icon: Icons.settings,
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Geçmiş Girişlerim',
    icon: Icons.history,
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Şifre Değiştir',
    icon: Icons.lock,
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Yardım & Destek',
    icon: Icons.help_outline,
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Hakkımızda',
    icon: Icons.info_outline,
    onPressed: () {},
  ),
  ProfileMenuItem(
    title: 'Çıkış Yap',
    icon: Icons.logout,
    onPressed: () {},
  ),
];
