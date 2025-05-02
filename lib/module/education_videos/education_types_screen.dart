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
                  margin: top10, child: VideoContainer(item: item));
            }),
      ),
    );
  }
}
