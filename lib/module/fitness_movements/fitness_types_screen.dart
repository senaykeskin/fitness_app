import 'package:fitness_app/module/fitness_detail/fitness_detail_screen.dart';

import 'index.dart';
import 'package:flutter/material.dart';

class FitnessTypesScreen extends StatelessWidget {
  final List<dynamic> categories;
  final String title;

  const FitnessTypesScreen(
      {super.key, required this.categories, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(context, title),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: top10,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return Container(
                    margin: bottom15 + horizontal10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(W(context), H(context) * 0.2),
                        elevation: 2,
                        backgroundColor: Colors.white,
                        overlayColor: GlobalConfig.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: border15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          RouteAnimation.createRoute(
                            FitnessDetailScreen(item: item),
                            1.0,
                            0.0,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: index % 2 == 0
                            ? [
                                SizedBox(
                                  width: W(context) * 0.4,
                                  child: Text(
                                    item['name'],
                                    textAlign: TextAlign.center,
                                    style: kAxiforma18.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3,
                                        color: GlobalConfig.primaryColor),
                                    borderRadius: border15,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: border15,
                                    child: Image.asset(
                                      item['image'],
                                      height: H(context) * 0.18,
                                      width: W(context) * 0.4,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ]
                            : [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3,
                                        color: GlobalConfig.primaryColor),
                                    borderRadius: border15,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: border15,
                                    child: Image.asset(
                                      item['image'],
                                      height: H(context) * 0.18,
                                      width: W(context) * 0.4,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: W(context) * 0.4,
                                  child: Text(
                                    item['name'],
                                    textAlign: TextAlign.center,
                                    style: kAxiforma18.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
