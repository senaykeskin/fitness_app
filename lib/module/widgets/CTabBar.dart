import 'package:flutter/material.dart';
import 'index.dart';

class CTabbar extends StatefulWidget {
  const CTabbar({super.key});

  @override
  State<CTabbar> createState() => _CTabbarState();
}

class _CTabbarState extends State<CTabbar> {
  final BehaviorSubject<int> _currentIndex$ = BehaviorSubject<int>.seeded(0);

  final List<Widget> _pages = [
    HomeScreen(),
    EntranceExitScreen(),
    ProductsScreen(),
    CircularProgressIndicator(),
  ];

  List<String> _tabLabels() => [
        "Ana Sayfa",
        "QR Kod",
        "Ürünler",
        "Profil",
      ];

  List<IconData> _tabIcons() => [
        Icons.home,
        Icons.qr_code_2,
        Icons.shopping_cart_rounded,
        Icons.person,
      ];

  @override
  void dispose() {
    _currentIndex$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _currentIndex$.stream,
      initialData: _currentIndex$.value,
      builder: (context, snapshot) {
        final currentIndex = snapshot.data ?? 0;
        return Scaffold(
          extendBody: true,
          body: _pages[currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: GlobalConfig.primaryColor,
            color: GlobalConfig.primaryColor,
            animationDuration: const Duration(milliseconds: 300),
            items: List.generate(
              _tabIcons().length,
              (index) => Container(
                margin: all5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_tabIcons()[index], color: Colors.white),
                    if (currentIndex != index)
                      Text(
                        _tabLabels()[index],
                        style: kAxiformaRegular17.copyWith(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
            onTap: (index) {
              _currentIndex$.add(index);
            },
          ),
        );
      },
    );
  }
}
