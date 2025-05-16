import 'package:fitness_app/module/membership_info/membership_info_screen.dart';

import 'index.dart';
import 'package:flutter/material.dart';

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
    if (!_banner.isClosed) _banner.add(bannerVisibleRight);
    await Future.delayed(const Duration(seconds: 3));
    if (!_banner.isClosed) _banner.add(bannerPartiallyVisibleRight);
  }

  @override
  void dispose() {
    _banner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int consecutiveEntries = 4;
    final int currentPeople = 35;
    final int maxCapacity = 100;
    final double percentage = currentPeople / maxCapacity;

    Color getDensityColor(double percentage) {
      if (percentage <= 0.35) return GlobalConfig.primaryColor;
      if (percentage <= 0.65) return Colors.orange.shade400;
      return Colors.red.shade600;
    }

    final dailyWaterGoal = calculateDailyWaterIntake(
      profileService.currentProfile.weight.toDouble(),
    );

    Widget memberShipCard() {
      final membershipType = "Gold";
      String icon;
      Color color;
      String description;

      switch (membershipType) {
        case "Gold":
          icon = "assets/images/gold.png";
          color = Color(0xffe8c96d);
          description = "Daha fazla avantajın keyfini çıkarın.";
          break;
        case "Platinum":
          icon = "assets/images/platinum.png";
          color = Colors.blueGrey.shade500;
          description = "Tüm ayrıcalıklar sizinle!";
          break;
        case "Silver":
        default:
          icon = "assets/images/silver.png";
          color = Colors.grey.shade500;
          description = "Temel üyelik avantajlarından faydalanın.";
      }

      return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              RouteAnimation.createRoute(
                  MembershipInformationScreen(), 1.0, 0.0));
        },
        style: ElevatedButton.styleFrom(
            foregroundColor: color,
            padding: vertical15 + horizontal20,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: border15,
                side: BorderSide(color: color.withAlpha(90), width: 1)),
            elevation: 2),
        child: Row(
          children: [
            Container(
              margin: all5,
              child: Image.asset(
                icon,
                width: W(context) * 0.15,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$membershipType Üyelik",
                    style: kAxiforma18.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: kAxiformaRegular17.copyWith(
                        fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 18, color: Colors.grey.shade400),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(children: [
          CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: horizontal15 + top15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hoş geldiniz Şenay Hanım,", style: kAxiforma18),
                    const SizedBox(height: 15),
                    memberShipCard(),
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
                              childAspectRatio: 1),
                      children: [
                        homeScreenInfoCard(
                          title: "Salon Doluluğu",
                          value: "%${(percentage * 100).toStringAsFixed(0)}",
                          leading: CircularPercentIndicator(
                            radius: W(context) * 0.1,
                            lineWidth: 8,
                            percent: percentage,
                            center: Text(
                              "%${(percentage * 100).toStringAsFixed(0)}",
                              style: kAxiformaRegular17.copyWith(fontSize: 14),
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
                            final percentageValue =
                                (totalConsumed / dailyWaterGoal)
                                    .clamp(0.0, 1.0);

                            return homeScreenInfoCard(
                              title: "Günlük Su İhtiyacı",
                              value:
                                  "${(waterIntake / 1000).toStringAsFixed(1)} L",
                              leading: CircularPercentIndicator(
                                radius: W(context) * 0.1,
                                lineWidth: 8,
                                percent: percentageValue,
                                center: Text(
                                  "%${(percentageValue * 100).floor()}",
                                  style:
                                      kAxiformaRegular17.copyWith(fontSize: 14),
                                ),
                                progressColor:
                                    getProgressColor(percentageValue),
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.grey.shade300,
                                animation: true,
                              ),
                              navigationIcon: Icons.edit_rounded,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    RouteAnimation.createRoute(
                                        WaterTrackingScreen(), 1.0, 0.0));
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
                            value: formatted(pastGymEntries[0].entryDateTime),
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
            eventSection("Yaklaşan Etkinlikler", upcomingEvents, context),
            eventSection("Üyeliğine Özel Etkinlikler", specialEvents, context),
            StreamBuilder<List<EventsModel>>(
              stream: myEventsSubject.stream,
              builder: (context, snapshot) {
                final myJoinedEvents = snapshot.data ?? [];
                if (myJoinedEvents.isEmpty) {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
                return eventSection(
                    "Katıldığım Etkinlikler", myJoinedEvents, context);
              },
            ),
            SliverPadding(
              padding: horizontal15 + top10 + bottom10,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: homeButtonList.length,
                  (context, index) {
                    final item = homeButtonList[index];
                    final icons = [
                      Icons.fitness_center_rounded,
                      Icons.person,
                      Icons.slow_motion_video_outlined
                    ];

                    return GestureDetector(
                      onTap: () => item['onTap'](context),
                      child: Container(
                        margin: bottom10,
                        padding: vertical15 + horizontal15,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: border15,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(2, 2),
                              ),
                            ],
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Row(
                          children: [
                            Container(
                              padding: all10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: Icon(
                                icons[index % icons.length],
                                size: 30,
                                color: GlobalConfig.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                item["title"],
                                style: kAxiforma18.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_forward, size: 22),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
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
                          topLeft: radius25, bottomLeft: radius25),
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
                            repeat: false,
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
            bottom: 10,
            right: 15,
            child: FloatingActionButton(
              elevation: 5,
              backgroundColor: Colors.white.withAlpha(220),
              onPressed: () {
                Navigator.push(
                  context,
                  RouteAnimation.createRoute(ChatBotScreen(), 1.0, 0.0),
                );
              },
              shape: RoundedRectangleBorder(borderRadius: border30),
              child: Image.asset(
                "assets/images/robot.png",
                width: 40,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
