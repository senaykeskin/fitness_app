import 'package:flutter/material.dart';
import 'index.dart';

class LoginHistoryScreen extends StatelessWidget {
  const LoginHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(context, "Geçmiş Salon Girişleri"),
      body: SafeArea(
        child: pastGymEntries.isEmpty
            ? Center(
                child: Text(
                  "Henüz bir giriş işlemi görünmüyor.",
                  style: kAxiformaRegular17.copyWith(
                      fontSize: 15, color: Colors.black),
                ),
              )
            : ListView.builder(
                padding: all15,
                itemCount: pastGymEntries.length,
                itemBuilder: (context, index) {
                  final entry = pastGymEntries[index];
                  return entryCard(entry);
                },
              ),
      ),
    );
  }
}
