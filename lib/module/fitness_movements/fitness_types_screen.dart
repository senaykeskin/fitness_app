import 'package:flutter/rendering.dart';

import 'index.dart';
import 'package:flutter/material.dart';

class FitnessTypesScreen extends StatelessWidget {
  final List<dynamic> categories;

  const FitnessTypesScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final item = categories[index];
                return Container(
                  margin: top10 + bottom15 + horizontal10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(W(context), H(context) * 0.2),
                      elevation: 2,
                      backgroundColor: Colors.white,
                      overlayColor: GlobalConfig.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: border15),
                    ),
                    onPressed: () {},
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
        ],
      ),
    );
  }
}
