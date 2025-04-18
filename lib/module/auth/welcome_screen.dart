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
          padding: top25 + horizontal20,
          child: Column(
            children: [
              Image.asset("assets/images/elektraweb.png", width: 250,),
              const SizedBox(height: 20),
              Text(
                "Hesap oluşturun veya mevcut hesabınıza giriş yapın",
                textAlign: TextAlign.center,
                style: kAxiformaRegular17.copyWith(fontSize: 15),
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
                              child: InkWell(
                                borderRadius: border30,
                                onTap: () => _onButtonTapped(0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Giriş Yap",
                                    style: kAxiformaRegular17.copyWith(
                                      color: selectedIndex == 0 ? Colors.white : Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                borderRadius: border30,
                                onTap: () => _onButtonTapped(1),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Hesap Oluştur",
                                    style: kAxiformaRegular17.copyWith(
                                      color: selectedIndex == 1 ? Colors.white : Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
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
                    const Login(),
                    const Signup(),
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
