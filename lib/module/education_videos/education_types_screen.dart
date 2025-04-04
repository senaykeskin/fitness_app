import 'index.dart';
import 'package:flutter/material.dart';

class EducationTypesScreen extends StatelessWidget {
  final List<dynamic> categories;
  final String title;

  const EducationTypesScreen(
      {super.key, required this.categories, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(context, title),
      body: Padding(
        padding: horizontal10,
        child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];
              return Container(
                margin: top10 + bottom8,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: GlobalConfig.primaryColor,
                        fixedSize: Size(W(context), H(context) * 0.15),
                        padding: horizontal5,
                        shape: RoundedRectangleBorder(
                          borderRadius: border15,
                        ),
                        elevation: 2),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset('assets/images/video.png',
                            width: W(context) * 0.3),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: W(context) * 0.57,
                                child: Text(
                                  item['name'],
                                  style: kAxiformaRegular17.copyWith(
                                      color: Colors.black, fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.grey,
                                  size: 23,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  item['time'],
                                  style: kAxiformaRegular17.copyWith(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
