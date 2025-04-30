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

  void showInfoDialog(BuildContext context, Map<int, int> extras) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: border15),
          backgroundColor: Colors.white,
          child: Padding(
            padding: horizontal20 + vertical15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'İçilen Su Detayı',
                  style: kAxiforma18.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                ...[100, 200, 300, 500].map((amount) {
                  final count = extras[amount] ?? 0;
                  return Padding(
                    padding: vertical5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$amount ml', style: kAxiformaRegular17),
                        Text('$count adet', style: kAxiformaRegular17),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalConfig.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: border10,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Tamam",
                    style: kAxiformaRegular17.copyWith(
                        fontSize: 14, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customAppBar(context, "Su Takibi"),
      body: Stack(
        children: [
          Padding(
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
                      tween: Tween<double>(
                          begin: 0, end: progress.clamp(0.0, 1.0)),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return CircularPercentIndicator(
                          radius: 60,
                          lineWidth: 12,
                          percent: value,
                          animation: false,
                          center: Text(
                            "%${(value * 100).toInt()}",
                            style: kAxiformaRegular17.copyWith(fontSize: 18),
                          ),
                          backgroundColor: Colors.grey.shade300,
                          progressColor: getProgressColor(value),
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
                      width: W(context) * 0.85,
                      padding: horizontal10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: GlobalConfig.primaryColor, width: 1.5),
                        borderRadius: border15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: W(context) * 0.55,
                            child: TextField(
                              style: kAxiformaRegular17.copyWith(fontSize: 15),
                              controller: customAmountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Özel değer girin... (ml)",
                                hintStyle:
                                    kAxiformaRegular17.copyWith(fontSize: 15),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.check_circle_outline,
                                color: GlobalConfig.primaryColor),
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
                          waterAmountButton(100, "(çay bardağı)"),
                          waterAmountButton(200, "(su bardağı)"),
                          waterAmountButton(300, "(kupa)"),
                          waterAmountButton(500, "(pet şişe)"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 60,
            right: 25,
            child: GestureDetector(
              onTap: () => showInfoDialog(context, waterSubject.value),
              child: Container(
                padding: all5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: border30,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.more_horiz_rounded,
                  size: 25,
                  color: GlobalConfig.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
