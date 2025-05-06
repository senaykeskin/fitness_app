import 'package:flutter/material.dart';
import 'index.dart';

class CTabbar extends StatefulWidget {
  final bool showAnimation;

  const CTabbar({super.key, this.showAnimation = false});

  @override
  State<CTabbar> createState() => _CTabbarState();
}

class _CTabbarState extends State<CTabbar> {
  int _currentIndex = 0;
  bool _showLanguageAnimation = false;

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
  void initState() {
    super.initState();
    if (widget.showAnimation) {
      _showLanguageAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
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
            alignment: Alignment.center,
            margin: all5,
            padding: _currentIndex != index ? top20 : zero,
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
                      color: Colors.white,
                    ),
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

    return Stack(
      children: [
        scaffold,
        if (_showLanguageAnimation) ...[
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withAlpha(50),
          ),
          Center(
            child: Container(
              width: W(context) * 0.8,
              padding: all20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: border30,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    spreadRadius: 3,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/animations/successful.json',
                    width: W(context) * 0.4,
                    height: W(context) * 0.4,
                    repeat: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Dil başarıyla değiştirildi!",
                    style: kAxiforma18.copyWith(
                        decoration: TextDecoration.none, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showLanguageAnimation = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalConfig.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: border15,
                      ),
                      padding: horizontal20 + vertical10,
                      elevation: 6,
                    ),
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: Text(
                      "Tamam",
                      style: kAxiforma18.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
