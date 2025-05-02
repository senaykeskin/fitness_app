import 'index.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Bildirim Ayarları"),
      body: ListView(
        padding: all10,
        children: [
          notificationCard(
            title: "Su Hatırlatmaları",
            subtitle: "Gün içinde su içmeyi hatırlatır.",
            icon: Icons.water_drop_rounded,
            subject: waterReminderSubject,
          ),
          notificationCard(
            title: "Sipariş Bildirimleri",
            subtitle: "Sipariş durumu hakkında bilgi verir.",
            icon: Icons.local_shipping_rounded,
            subject: orderNotificationSubject,
          ),
          notificationCard(
            title: "Antrenman Hatırlatmaları",
            subtitle: "Planladığınız antrenman saatlerini hatırlatır.",
            icon: Icons.fitness_center_rounded,
            subject: workoutReminderSubject,
          ),
          notificationCard(
            title: "Hedef Bildirimleri",
            subtitle: "Hedeflerinize ulaşıp ulaşmadığınızı bildirir.",
            icon: Icons.flag_rounded,
            subject: goalNotificationSubject,
          ),
          notificationCard(
            title: "Kampanyalar",
            subtitle: "Yeni kampanyalardan haberdar olun.",
            icon: Icons.discount_rounded,
            subject: campaignNotificationSubject,
          ),
          notificationCard(
            title: "Duyurular",
            subtitle: "Genel duyurular ve bilgilendirmeler.",
            icon: Icons.campaign_rounded,
            subject: announcementNotificationSubject,
          ),
        ],
      ),
    );
  }
}
