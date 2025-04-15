import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'index.dart';

class CTabbar extends StatefulWidget {
  final bool showAnimation;

  const CTabbar({super.key, this.showAnimation = false});

  @override
  State<CTabbar> createState() => _CTabbarState();
}

class _CTabbarState extends State<CTabbar> {
  int _currentIndex = 0;
  bool _showOverlayAnimation = false;

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
      _showOverlayAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _pages[_currentIndex],
          if (_showOverlayAnimation)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: border25,
                  border: Border.all(width: 2, color: Colors.black)
                ),
                width: W(context) * 0.8,
                height: H(context) * 0.32,
                child: Column(
                  children: [
                    Container(
                      margin: top20,
                      child: Lottie.asset(
                        'assets/animations/successful.json',
                        width: 140,
                        height: 140,
                        repeat: false,
                      ),
                    ),
                    Padding(
                      padding: top10,
                      child: Text(
                        "Dil başarıyla değiştirildi.",
                        style: kAxiformaRegular17.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showOverlayAnimation = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalConfig.primaryColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: border10,
                        ),
                        padding: horizontal20 + vertical10,
                      ),
                      child: Text(
                        "Tamam",
                        style: kAxiforma18.copyWith(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
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
            padding: _currentIndex != index ?  top20 : zero,
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
  }
}
