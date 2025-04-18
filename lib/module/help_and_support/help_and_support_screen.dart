import 'index.dart';
import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(context, "Yardım ve Destek"),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: top20 + horizontal15,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    "Sık Sorulan Sorular",
                    style: kAxiformaRegular17.copyWith(
                        decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 10),
                  ...faqs.map((faq) =>
                      sssContainers(context, faq["question"]!, faq["answer"]!)),
                  const SizedBox(height: 20),
                  Text(
                    "Geri Bildirim Gönder",
                    style: kAxiformaRegular17.copyWith(
                        decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 16),
                  feedbackForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
