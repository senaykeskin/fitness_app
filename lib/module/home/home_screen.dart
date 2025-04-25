import 'package:fitness_app/module/chat_bot_screen/chat_bot_screen.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool isInGym = true;
  final _banner = BehaviorSubject<double>.seeded(-250);

  double get bannerVisibleRight => 0;

  double get bannerPartiallyVisibleRight => -200;

  final waterIntake = calculateDailyWaterIntake(
      profileService.currentProfile.weight.toDouble());

  @override
  void initState() {
    super.initState();
    if (isInGym && bannerShown.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showAnimatedBanner();
        bannerShown.add(false);
      });
    } else {
      _banner.add(bannerPartiallyVisibleRight);
    }
  }

  Future<void> showAnimatedBanner() async {
    _banner.add(bannerVisibleRight);
    await Future.delayed(const Duration(seconds: 3));
    _banner.add(bannerPartiallyVisibleRight);
  }

  @override
  void dispose() {
    _banner.close();
    bannerShown.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int consecutiveEntries = 4;
    final int currentPeople = 55;
    final int maxCapacity = 100;
    final double percentage = currentPeople / maxCapacity;

    Color getDensityColor(double percentage) {
      if (percentage <= 0.35) {
        return Colors.green;
      } else if (percentage <= 0.65) {
        return Colors.orange.shade400;
      } else {
        return Colors.red.shade700;
      }
    }

    final dailyWaterGoal = calculateDailyWaterIntake(
      profileService.currentProfile.weight.toDouble(),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: horizontal15 + top15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hoş geldin 👋",
                          style: kAxiforma18.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 15),
                        const WeeklyGymCalendar(),
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.1,
                          ),
                          children: [
                            homeScreenInfoCard(
                              title: "Salon Yoğunluğu",
                              value:
                                  "%${(percentage * 100).toStringAsFixed(0)}",
                              leading: CircularPercentIndicator(
                                radius: 33,
                                lineWidth: 8,
                                percent: percentage,
                                center: Text(
                                  "%${(percentage * 100).toStringAsFixed(0)}",
                                  style:
                                      kAxiformaRegular17.copyWith(fontSize: 14),
                                ),
                                progressColor: getDensityColor(percentage),
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.grey.shade300,
                                animation: true,
                              ),
                            ),
                            StreamBuilder<Map<int, int>>(
                              stream: waterSubject.stream,
                              builder: (context, snapshot) {
                                final extras = snapshot.data ?? {};

                                final totalConsumed = extras.entries
                                    .map((e) => e.key * e.value)
                                    .fold(0, (prev, curr) => prev + curr);

                                final percentage =
                                    (totalConsumed / dailyWaterGoal)
                                        .clamp(0.0, 1.0);

                                return homeScreenInfoCard(
                                  title: "Günlük Su İhtiyacı",
                                  value:
                                      "${(waterIntake / 1000).toStringAsFixed(1)} L",
                                  leading: CircularPercentIndicator(
                                    radius: 33,
                                    lineWidth: 8,
                                    percent: percentage,
                                    center: Text(
                                      "%${(percentage * 100).toStringAsFixed(0)}",
                                      style: kAxiformaRegular17.copyWith(
                                          fontSize: 14),
                                    ),
                                    progressColor: GlobalConfig.primaryColor,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: Colors.grey.shade300,
                                    animation: true,
                                  ),
                                  navigationIcon: Icons.edit_rounded,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      RouteAnimation.createRoute(
                                          WaterTrackingScreen(), 1.0, 0.0),
                                    );
                                  },
                                );
                              },
                            ),
                            homeScreenInfoCard(
                                title: "Seri",
                                value: "$consecutiveEntries gün",
                                leading: Icon(Icons.star_border_purple500,
                                    color: Colors.yellow.shade800, size: 45),
                                navigationIcon: Icons.info_rounded,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      RouteAnimation.createRoute(
                                          StreakScreen(), 1.0, 0.0));
                                }),
                            homeScreenInfoCard(
                                title: "Son Giriş",
                                value:
                                    formatted(pastGymEntries[0].entryDateTime),
                                leading: Icon(Icons.access_time,
                                    color: Colors.teal.shade800, size: 45),
                                navigationIcon: Icons.info_rounded,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      RouteAnimation.createRoute(
                                          LoginHistoryScreen(), 1.0, 0.0));
                                }),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: horizontal15,
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: homeButtonList.length,
                      (context, index) {
                        final item = homeButtonList[index];
                        return Container(
                          margin: bottom10,
                          decoration: BoxDecoration(
                            borderRadius: border15,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          width: W(context),
                          height: 200,
                          child: InkWell(
                            onTap: () => item['onTap'](context),
                            child: ClipRRect(
                              borderRadius: border15,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      item['image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: vertical15,
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(153, 0, 0, 0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          item["title"],
                                          style: kAxiforma18.copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
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
            StreamBuilder<double>(
              stream: _banner.stream,
              initialData: _banner.value,
              builder: (context, snapshot) {
                final right = snapshot.data ?? -250;
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                  top: 10,
                  right: right,
                  child: GestureDetector(
                    onTap: showAnimatedBanner,
                    child: Container(
                      width: 250,
                      padding: horizontal10 + vertical10,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: radius25,
                          bottomLeft: radius25,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Lottie.asset(
                              'assets/animations/active.json',
                              repeat: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Şu anda salondasınız!",
                              style: kAxiformaRegular17.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                                overflow: TextOverflow.ellipsis,
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
            Positioned(
              bottom: 20,
              right: 15,
              child: FloatingActionButton(
                elevation: 5,
                backgroundColor: Colors.grey.shade100,
                onPressed: () {
                  Navigator.push(
                      context,
                      RouteAnimation.createRoute(
                        ChatBotScreen(),
                        -1.0,
                        0.0,
                      ));
                },
                shape: RoundedRectangleBorder(borderRadius: border30),
                child: Image.asset(
                  "assets/images/robot.png",
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
