import 'package:fitness_app/module/streak_screen/streak_list.dart';
import '../../global/global_variables.dart';
import '../../global/global_widgets.dart';
import 'package:flutter/material.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStreak = 4;
    final bestStreak =
        dummyStreakData.map((s) => s.days).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: customAppBar(context, "Seri Takibi"),
      body: SingleChildScrollView(
        padding: all15,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                streakInfoCard(
                    "Mevcut Seri", "$currentStreak Gün", Colors.blue),
                streakInfoCard("Rekor Seri", "$bestStreak Gün", Colors.orange),
              ],
            ),
            const SizedBox(height: 15),
            barChart(dummyStreakData),
            const SizedBox(height: 15),
            streakContainer(context, dummyStreakData),
          ],
        ),
      ),
    );
  }
}
