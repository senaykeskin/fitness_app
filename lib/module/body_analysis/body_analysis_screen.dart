import 'package:fitness_app/global/global_config.dart';
import 'package:fitness_app/global/global_variables.dart';
import 'package:fitness_app/global/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:lottie/lottie.dart';
import '../profile/profile_subjects.dart';

class BodyAnalysisScreen extends StatelessWidget {
  const BodyAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customAppBar(context, "Vücut Analizi"),
      body: StreamBuilder(
        stream: profileService.profileStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = snapshot.data!;
          final bmi = calculateBMI(profile.height.toDouble(), profile.weight.toDouble());
          final bmiCategory = getBMICategory(bmi);
          final waterIntake = calculateDailyWaterIntake(profile.weight.toDouble());
          final calorieNeeds = calculateDailyCalories(
            profile.gender,
            profile.height.toDouble(),
            profile.weight.toDouble(),
            profile.age,
          );

          return Padding(
            padding: all10,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset(
                    profile.gender == "Kadın"
                        ? 'assets/animations/female_fitness.json'
                        : 'assets/animations/male_fitness.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "BMI: ${bmi.toStringAsFixed(1)} ($bmiCategory)",
                    style: kAxiformaRegular17.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CircularPercentIndicator(
                    radius: 90.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: (bmi / 40).clamp(0.0, 1.0),
                    center: Text(
                      bmi.toStringAsFixed(1),
                      style: kAxiformaRegular17.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    footer: Padding(
                      padding: top20,
                      child: Text(
                        "Vücut Kitle İndeksi",
                        style: kAxiformaRegular17.copyWith(fontSize: 15),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.grey.shade300,
                    progressColor: GlobalConfig.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  infoTile("Günlük Kalori İhtiyacı",
                      "${calorieNeeds.toStringAsFixed(0)} kcal"),
                  const SizedBox(height: 10),
                  infoTile("Günlük Su İhtiyacı",
                      "${(waterIntake / 1000).toStringAsFixed(1)} L"),
                  const SizedBox(height: 10),
                  infoTile("Boy", "${profile.height} cm"),
                  const SizedBox(height: 10),
                  infoTile("Kilo", "${profile.weight} kg"),
                  const SizedBox(height: 10),
                  infoTile("Yaş", "${profile.age}"),
                  const SizedBox(height: 10),
                  infoTile("Cinsiyet", profile.gender),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
