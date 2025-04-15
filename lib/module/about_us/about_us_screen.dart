import 'index.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(context, "Hakkımızda"),
      body: Padding(
        padding: all15,
        child: ListView(
          children: [
            aboutUsTitle(
              "FitnessApp'e Hoş Geldiniz",
            ),
            aboutUsText(
                "FitnessApp, spor salonu deneyimini tamamen dijitalleştirerek antrenman, QR giriş ve ürün alışverişi gibi birçok özelliği tek platformda toplar."),
            const SizedBox(height: 30),
            aboutUsTitle("Amacımız"),
            aboutUsText(
              "Daha fazla insanın spora düzenli erişmesini sağlamak ve bu süreci kolay, kişiselleştirilmiş ve teknolojik hale getirmek.",
            ),
            const SizedBox(height: 30),
            aboutUsTitle("Vizyonumuz"),
            aboutUsText(
                "Kişisel antrenman dünyasında yenilikçi çözümler sunarak hem kullanıcılar hem de spor salonları için vazgeçilmez bir platform olmak."),
            const SizedBox(height: 30),
            aboutUsTitle("Bize Ulaşın"),
            aboutUsText(
              "📞 0212 000 00 00\n📧 destek@fitnessapp.com\n\nSorularınız, önerileriniz veya geri bildiriminiz varsa bizimle her zaman iletişime geçebilirsiniz.",
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "© 2025 FitnessApp",
                style: kAxiformaRegular17.copyWith(
                    fontSize: 12, color: Colors.black.withAlpha(100)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
