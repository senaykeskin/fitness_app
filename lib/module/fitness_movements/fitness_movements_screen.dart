import 'package:flutter/material.dart';
import 'index.dart';

class FitnessMovementsScreen extends StatelessWidget {
  const FitnessMovementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategoriler",
          style: kAxiforma18,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: horizontal10 + top20,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.8,
          ),
          itemCount: fitnessList.length,
          itemBuilder: (context, index) {
            final item = fitnessList[index];
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: border15,
                      side: BorderSide(
                          color: GlobalConfig.primaryColor, width: 1))),
              onPressed: () {
                Navigator.push(
                  context,
                  RouteAnimation.createRoute(
                    FitnessTypesScreen(
                      categories: item['categories'],
                      title: item['title'],
                    ),
                    1.0,
                    0.0,
                    arguments: item['categories'],
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: border15,
                    child: Image.asset(
                      item['image'],
                      width: W(context) * 0.40,
                      height: W(context) * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    item['title'],
                    style: kAxiforma18.copyWith(
                        fontSize: W(context) / 32, color: Colors.black),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
