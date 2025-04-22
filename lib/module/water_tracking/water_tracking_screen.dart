import 'index.dart';
import 'package:flutter/material.dart';

class WaterTrackingScreen extends StatelessWidget {
  WaterTrackingScreen({super.key});

  final double cupSizeMl = 200;

  final waterIntake = calculateDailyWaterIntake(
      profileService.currentProfile.weight.toDouble());

  final TextEditingController customAmountController = TextEditingController();

  void addCustomAmount(BuildContext context) {
    final text = customAmountController.text;
    if (text.isNotEmpty) {
      final int? value = int.tryParse(text);
      if (value != null) {
        final current = waterSubject.value;
        final updated = Map<int, int>.from(current);
        updated[value] = (updated[value] ?? 0) + 1;
        waterSubject.add(updated);
        customAmountController.clear();
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customAppBar(context, "Su Takibi"),
      body: Padding(
        padding: all15,
        child: StreamBuilder<Map<int, int>>(
          stream: waterSubject.stream,
          builder: (context, snapshot) {
            final extras = snapshot.data ?? {};

            final totalConsumed = extras.entries
                .map((e) => e.key * e.value)
                .fold(0, (prev, curr) => prev + curr);

            final progress = totalConsumed / waterIntake;

            return Column(
              children: [
                Text(
                  'Günlük Su Hedefine Ulaşma',
                  style: kAxiforma18,
                ),
                const SizedBox(height: 12),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress.clamp(0.0, 1.0)),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 12,
                      percent: value,
                      animation: false,
                      center: Text(
                        "%${(value * 100).toInt()}",
                        style: kAxiformaRegular17.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.grey.shade300,
                      progressColor: GlobalConfig.primaryColor,
                      circularStrokeCap: CircularStrokeCap.round,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  '${(totalConsumed).toInt()} ml / ${waterIntake.toInt()} ml',
                  style: kAxiformaRegular17,
                ),
                const SizedBox(height: 20),
                Container(
                  width: W(context) * 0.75,
                  padding: horizontal10,
                  decoration: BoxDecoration(
                    border: Border.all(color: GlobalConfig.primaryColor),
                    borderRadius: border15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextField(
                          style: kAxiformaRegular17.copyWith(fontSize: 15),
                          controller: customAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "(ml)",
                            hintStyle:
                                kAxiformaRegular17.copyWith(fontSize: 15),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: GlobalConfig.primaryColor),
                        onPressed: () {
                          final text = customAmountController.text;
                          final value = int.tryParse(text);
                          if (value != null) {
                            toggleAmount(value, true);
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      waterAmountButton(100, "assets/images/tea.png"),
                      waterAmountButton(200, "assets/images/glass.png"),
                      waterAmountButton(300, "assets/images/coffee-glass.png"),
                      waterAmountButton(500, "assets/images/water-bottle.png"),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
