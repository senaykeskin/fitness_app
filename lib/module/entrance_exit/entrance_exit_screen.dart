import 'index.dart';
import 'package:flutter/material.dart';

class EntranceExitScreen extends StatefulWidget {
  const EntranceExitScreen({super.key});

  @override
  State<EntranceExitScreen> createState() => _EntranceExitScreenState();
}

class _EntranceExitScreenState extends State<EntranceExitScreen> {
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
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: top25 + horizontal20,
          child: Column(
            children: [
              Text(
                "QR kodunuzu cihaz üzerindeki kameraya okutarak veya cihaz üzerindeki QR kodu "
                "kameranızla tarayarak giriş yapabilirsiniz.",
                style: kAxiformaRegular17.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: top20,
                child: StreamBuilder<int>(
                  stream: _selectedIndex.stream,
                  initialData: 0,
                  builder: (context, snapshot) {
                    int selectedIndex = snapshot.data ?? 0;
                    return Container(
                      padding: horizontal5 + vertical5,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
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
                              width: W(context) * 0.45,
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
                                    child: Text("QR Göster",
                                        style: kAxiformaRegular17.copyWith(
                                            color: selectedIndex == 0
                                                ? Colors.white
                                                : Colors.grey.shade200,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _onButtonTapped(1),
                                  child: Center(
                                    child: Text("QR Okut",
                                        style: kAxiformaRegular17.copyWith(
                                            color: selectedIndex == 1
                                                ? Colors.white
                                                : Colors.grey.shade200,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
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
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const ShowQrCode(),
                    const ScanQrCode(),
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
