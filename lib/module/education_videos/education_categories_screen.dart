import 'package:flutter/material.dart';
import 'index.dart';

class EducationCategoriesScreen extends StatelessWidget {
  const EducationCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(context, "Kategoriler"),
      body: Padding(
        padding: horizontal10,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 0,
            childAspectRatio: 0.8,
          ),
          itemCount: fitnessList.length,
          itemBuilder: (context, index) {
            final item = fitnessList[index];
            return Container(
              margin: bottom8 + top10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: border15,
                  ),
                  padding: EdgeInsets.all(0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteAnimation.createRoute(
                      EducationTypesScreen(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: border15,
                      child: Image.asset(
                        item['image'],
                        width: W(context) * 0.4,
                        height: W(context) * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item['title'],
                      style: kAxiforma18.copyWith(
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
