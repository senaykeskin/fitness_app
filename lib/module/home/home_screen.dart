import 'package:flutter/material.dart';
import 'index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> _imagePaths = [
    'assets/images/home-vertical1.jpg',
    'assets/images/home-vertical2.jpg',
    'assets/images/home-vertical3.jpg',
    'assets/images/home-vertical4.jpg',
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final nextIndex = (_currentIndex + 1) % _imagePaths.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: H(context) * 0.55,
            floating: false,
            pinned: true,
            flexibleSpace: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _imagePaths.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _imagePaths[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: H(context),
                      cacheWidth: W(context).toInt(),
                      cacheHeight: (H(context) * 0.55).toInt(),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _imagePaths.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 700),
                        margin: horizontal5,
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? GlobalConfig.primaryColor
                              : Colors.grey,
                          borderRadius: border15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: horizontal10 + vertical10 + bottom80,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: homeButtonList.length,
                (context, index) {
                  final item = homeButtonList[index];
                  return Container(
                    margin: vertical5,
                    decoration: BoxDecoration(
                      borderRadius: border15,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    width: W(context),
                    height: 250,
                    child: InkWell(
                      onTap: () => item['onTap'](context),
                      child: ClipRRect(
                        borderRadius: border15,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: vertical15,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(153, 0, 0, 0),
                                ),
                                child: Center(
                                  child: Text(item["title"],
                                      style: kAxiforma18.copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
