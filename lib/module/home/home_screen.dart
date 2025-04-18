import 'package:flutter/material.dart';
import 'index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String gymDensity = "Az";
    final int consecutiveEntries = 4;

    Color getDensityColor(String level) {
      switch (level) {
        case 'Az':
          return Colors.green;
        case 'Orta':
          return Colors.orange;
        case 'Çok':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    final waterIntake = calculateDailyWaterIntake(
        profileService.currentProfile.weight.toDouble());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: horizontal15 + vertical15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hoş geldin 👋",
                      style: kAxiforma18.copyWith(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          value: gymDensity,
                          color: getDensityColor(gymDensity),
                          icon: Icons.fitness_center,
                        ),
                        homeScreenInfoCard(
                          title: "Su İhtiyacı",
                          value: "${(waterIntake / 1000).toStringAsFixed(1)} L",
                          color: Colors.blue,
                          icon: Icons.water_drop,
                        ),
                        homeScreenInfoCard(
                          title: "Üst Üste Giriş",
                          value: "$consecutiveEntries gün",
                          color: Colors.yellow.shade800,
                          icon: Icons.star_rounded,
                        ),
                        homeScreenInfoCard(
                          title: "Son Giriş",
                          value:
                              formatDateTime(pastGymEntries[0].entryDateTime),
                          color: Colors.teal.shade800,
                          icon: Icons.access_time,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: horizontal15 + bottom10,
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
      ),
    );
  }
}
