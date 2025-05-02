import 'index.dart';
import 'package:flutter/material.dart';

class FitnessDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const FitnessDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
                  padding: all10,
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
                  padding: horizontal10 + bottom10,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: bottom10,
                          child: VideoContainer(item: item),
                        ),
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
                        Text("Hedef",
                            style: kAxiforma18.copyWith(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            )),
                        SizedBox(height: 10),
                        Container(
                          width: W(context),
                          padding: vertical15,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: border15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${item['repeat']}",
                                    style: kAxiformaRegular17.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "tekrar",
                                    style: kAxiformaRegular17.copyWith(
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: horizontal20,
                                child: Text("X", style: kAxiformaRegular17),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${item['set']}",
                                      style: kAxiformaRegular17.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  Text("set",
                                      style: kAxiformaRegular17.copyWith(
                                          fontSize: 15)),
                                ],
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
