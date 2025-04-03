import 'package:flutter/material.dart';
import 'index.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final BehaviorSubject<int> _selectedIndex = BehaviorSubject<int>.seeded(0);
  final PageController _pageController = PageController();

  void _onButtonTapped(int index) {
    _selectedIndex.add(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _selectedIndex.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: top50 + horizontal20,
          child: Column(
            children: [
              Text(
                "Hoş Geldiniz",
                style: kAxiforma24.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                "Hesap oluşturun veya mevcut hesabınıza giriş yapın",
                textAlign: TextAlign.center,
                style: kAntarctican20,
              ),
              const SizedBox(height: 20),
              StreamBuilder<int>(
                stream: _selectedIndex.stream,
                initialData: 0,
                builder: (context, snapshot) {
                  int selectedIndex = snapshot.data ?? 0;
                  return Container(
                    padding: horizontal5 + vertical5,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: border30,
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          alignment: selectedIndex == 0
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: GlobalConfig.primaryColor,
                              borderRadius: border30,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _onButtonTapped(0),
                                child: Center(
                                  child: Text(
                                    "Hesap Oluştur",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 0
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _onButtonTapped(1),
                                child: Center(
                                  child: Text(
                                    "Giriş Yap",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 1
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const Signup(),
                    const Login(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
