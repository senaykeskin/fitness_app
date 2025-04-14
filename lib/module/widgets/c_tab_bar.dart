import 'package:flutter/material.dart';
import 'index.dart';

class CTabbar extends StatefulWidget {
  const CTabbar({super.key});

  @override
  State<CTabbar> createState() => _CTabbarState();
}

class _CTabbarState extends State<CTabbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    EntranceExitScreen(),
    ProductsScreen(),
    ProfileScreen(),
  ];

  final List<String> _tabLabels = [
    "Ana Sayfa",
    "QR Kod",
    "Ürünler",
    "Profil",
  ];

  final List<IconData> _tabIcons = [
    Icons.home,
    Icons.qr_code_2,
    Icons.shopping_cart_rounded,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: GlobalConfig.primaryColor,
        color: GlobalConfig.primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        items: List.generate(
          _tabIcons.length,
          (index) => Container(
            margin: all5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_tabIcons[index], color: Colors.white),
                if (_currentIndex != index)
                  Text(
                    _tabLabels[index],
                    style: kAxiformaRegular17.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
