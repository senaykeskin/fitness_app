import 'index.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BehaviorSubject<int> _currentIndex$ = BehaviorSubject<int>.seeded(0);
  final PageController _pageController = PageController();

  final List<String> _imagePaths = [
    'assets/images/home-image1.png',
    'assets/images/home-image2.png',
    'assets/images/home-image3.png',
    'assets/images/home-image4.png',
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 25), (timer) {
      final currentIndex = _currentIndex$.value;
      final nextIndex = (currentIndex + 1) % _imagePaths.length;
      _currentIndex$.add(nextIndex);
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _currentIndex$.close();
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
            expandedHeight: H(context) * 0.35,
            floating: false,
            pinned: true,
            flexibleSpace: StreamBuilder<int>(
              stream: _currentIndex$.stream,
              builder: (context, snapshot) {
                final currentIndex = snapshot.data ?? 0;
                return Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: _imagePaths.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _imagePaths[index],
                          fit: BoxFit.cover,
                          width: W(context),
                          height: H(context) * 0.35,
                        );
                      },
                      onPageChanged: (index) {
                        _currentIndex$.add(index);
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
                              color: currentIndex == index
                                  ? GlobalConfig.primaryColor
                                  : Colors.grey,
                              borderRadius: border15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
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
                    height: H(context) * 0.3,
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
