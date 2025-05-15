import 'index.dart';
import 'package:flutter/material.dart';

class WarmUpExercisesScreen extends StatelessWidget {
  const WarmUpExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Isınma Hareketleri"),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            padding: all10,
            child: Text(
              "Egzersize başlamadan önce ısının!",
              style: kAxiformaRegular17.copyWith(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: warmUps.length,
              padding: horizontal10 + bottom10,
              itemBuilder: (context, index) {
                final exercise = warmUps[index];
                return Card(
                  color: Colors.white,
                  margin: bottom10,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: border15,
                      side: BorderSide(color: Colors.grey.shade100)),
                  child: Padding(
                    padding: all10,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: border10,
                          child: Lottie.asset(exercise.animation,
                              width: 100, height: 100, repeat: false),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise.name,
                                style: kAxiforma18.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                exercise.description,
                                style: kAxiformaRegular17.copyWith(
                                    fontSize: 13, color: Colors.grey.shade700),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "${exercise.duration} saniye",
                                style:
                                kAxiformaRegular17.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  WarmUpTimerDialog(exercise: exercise),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalConfig.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: border10,
                            ),
                          ),
                          child: Text(
                            "Başla",
                            style: kAxiformaRegular17.copyWith(
                                fontSize: 12, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
