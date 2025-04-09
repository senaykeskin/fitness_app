import 'index.dart';
import 'package:flutter/material.dart';

class FitnessDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const FitnessDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                item['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: horizontal10,
                  child: Center(
                    child: Text(
                      item['name'],
                      style: kAxiforma18.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: horizontal10 + top20 + bottom15,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['how'],
                          style: kAxiforma18.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          item['desc'],
                          style: kAxiformaRegular17.copyWith(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text.rich(
                          textAlign: TextAlign.center,
                          style: kAxiformaRegular17.copyWith(fontSize: 15),
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Tekrar: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: "${item['repeat']}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
