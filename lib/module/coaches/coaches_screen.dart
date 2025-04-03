import 'package:fitness_app/module/coaches/coach_detail_screen.dart';
import 'package:fitness_app/module/home/index.dart';
import 'package:flutter/material.dart';

class CoachesScreen extends StatelessWidget {
  const CoachesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> array = homeButtonList[1]['coaches'];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text("Kişisel Antrenörler", style: kAxiforma18),
          centerTitle: true,
        ),
        body: Expanded(
            child: ListView.builder(
                padding: horizontal10 + bottom15,
                itemCount: array.length,
                itemBuilder: (context, index) {
                  final item = array[index];
                  return Padding(
                    padding: top10,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape:
                                RoundedRectangleBorder(borderRadius: border15),
                            fixedSize: Size(W(context), H(context) * 0.15),
                            backgroundColor: Colors.white,
                            foregroundColor: GlobalConfig.primaryColor,
                            elevation: 2),
                        onPressed: () {
                          Navigator.push(
                            context,
                            RouteAnimation.createRoute(
                              CoachDetailScreen(item: item),
                              1.0,
                              0.0,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Image.asset(item['photo'], width: 70),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: kAxiforma18.copyWith(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: "Yaş: ",
                                      style: kAxiforma18.copyWith(
                                          fontSize: 13, color: Colors.black)),
                                  TextSpan(
                                      text: "${item['age']}",
                                      style: kAxiformaRegular17.copyWith(
                                          fontSize: 13, color: Colors.black))
                                ])),
                                SizedBox(
                                  width: W(context) * 0.6,
                                  child: Text.rich(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      TextSpan(children: [
                                        TextSpan(
                                            text: "Alan: ",
                                            style: kAxiforma18.copyWith(
                                                fontSize: 13,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: "${item['field']}",
                                            style: kAxiformaRegular17.copyWith(
                                                fontSize: 13,
                                                color: Colors.black))
                                      ])),
                                )
                              ],
                            )
                          ],
                        )),
                  );
                })));
  }
}
