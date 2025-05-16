import 'index.dart';
import 'package:flutter/material.dart';

class CoachDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const CoachDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Randevu Al"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: W(context),
              height: H(context) * 0.35,
              decoration: BoxDecoration(
                color: Colors.amberAccent.shade100,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withValues(alpha: (0.3)))
                ],
              ),
              child: Center(
                child: Image.asset(
                  item['photo'],
                  width: W(context) * 0.6,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: horizontal20,
              child: Text(item['name'],
                  style:
                      kAxiforma18.copyWith(fontSize: 24, color: Colors.black)),
            ),
            SizedBox(height: 5),
            Padding(
                padding: horizontal20,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Yaş: ",
                        style: kAxiformaRegular17.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: "${item['age']} | ",
                        style: kAxiformaRegular17.copyWith(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                        text: "Alan: ",
                        style: kAxiformaRegular17.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: "${item['field']}",
                        style: kAxiformaRegular17.copyWith(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 20),
            Padding(
              padding: horizontal20,
              child: Text(
                item['description'],
                textAlign: TextAlign.center,
                style: kAxiformaRegular17.copyWith(
                    fontSize: 14, color: Colors.black87),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 15,
              runSpacing: 10,
              children: item['services'].map<Widget>((service) {
                return Container(
                  padding: horizontal10 + vertical5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: border10,
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: Colors.grey.shade600),
                    ],
                  ),
                  child: Text(
                    service,
                    style: kAxiformaRegular17.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: horizontal20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow("Deneyim", item['experience']),
                  buildInfoRow(
                      "Çalışma Günleri", item['availableDays'].join(", ")),
                  buildInfoRow(
                      "Çalışma Saatleri", item['availableHours'].join(", ")),
                  buildInfoRow("Seans Süresi", item['sessionDuration']),
                  buildInfoRow("Ücret", item['pricing']),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: horizontal20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalConfig.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: border15,
                  ),
                  padding: vertical15,
                  minimumSize: Size(W(context), 50),
                ),
                onPressed: () {
                  showSnackBar(context, "Randevu oluşturuldu!");
                },
                child: Text(
                  "Randevu Al",
                  style: kAxiformaRegular17.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
