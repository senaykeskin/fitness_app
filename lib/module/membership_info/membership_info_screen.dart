import 'index.dart';
import 'package:flutter/material.dart';

class MembershipInformationScreen extends StatefulWidget {
  const MembershipInformationScreen({super.key});

  @override
  State<MembershipInformationScreen> createState() =>
      _MembershipInformationScreenState();
}

class _MembershipInformationScreenState
    extends State<MembershipInformationScreen> {
  final BehaviorSubject<int> selectedIndexSubject =
      BehaviorSubject<int>.seeded(0);

  @override
  void dispose() {
    selectedIndexSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(context, "Üyelik Bilgileri"),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.chevron_left_outlined,
                  color: Colors.black38, size: W(context) * 0.05),
              SizedBox(
                height: W(context) * 0.6,
                width: W(context) * 0.9,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      itemCount: memberships.length,
                      onPageChanged: (index) => selectedIndexSubject.add(index),
                      itemBuilder: (context, index) {
                        final membership = memberships[index];
                        return Padding(
                          padding: vertical10 + horizontal10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: border20,
                              image: DecorationImage(
                                image: AssetImage(membership.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: horizontal10 + vertical15,
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/images/elektraweb.png",
                                          width: W(context) * 0.45,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Üye Numarası",
                                              style:
                                                  kAxiformaRegular17.copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade800),
                                            ),
                                            Text(
                                              "27376286",
                                              style:
                                                  kAxiformaRegular17.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Son Geçerlilik Tarihi",
                                              style:
                                                  kAxiformaRegular17.copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade800),
                                            ),
                                            Text(
                                              formatDateTimeWithoutHour(
                                                  membership.validUntil),
                                              style:
                                                  kAxiformaRegular17.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Image.asset(
                                      membership.badge,
                                      width: W(context) * 0.2,
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    child: membership.situation
                                        ? Container(
                                            padding: horizontal15 + vertical5,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.green,
                                                  Colors.teal
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: border25,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  offset: const Offset(2, 2),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.check_circle,
                                                    color: Colors.white,
                                                    size: 17),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "Aktif",
                                                  style: kAxiforma18.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            padding: horizontal15 + vertical5,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.grey,
                                                  Colors.blueGrey
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: border25,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  offset: const Offset(2, 2),
                                                )
                                              ],
                                            ),
                                            child: const Icon(Icons.lock,
                                                color: Colors.white, size: 17),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_outlined,
                  color: Colors.black38, size: W(context) * 0.05),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: verticalTop30,
              ),
              padding: horizontal15,
              child: StreamBuilder<int>(
                stream: selectedIndexSubject.stream,
                builder: (context, snapshot) {
                  final index = snapshot.data ?? 0;
                  final membership = memberships[index];
                  return ListView(
                    children: [
                      Container(
                        margin: top25,
                        child: Text(
                          "${membership.name} Üyelik Avantajları",
                          style: kAxiforma18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ...membership.benefits.map(
                        (benefit) => ListTile(
                          leading: Icon(Icons.check_circle,
                              color: GlobalConfig.primaryColor),
                          title: Text(benefit,
                              style: kAxiformaRegular17.copyWith(fontSize: 15)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      membership.situation
                          ? Container(
                              width: W(context),
                              height: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: GlobalConfig.primaryColor,
                                  width: 2.0,
                                ),
                                borderRadius: border15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle_outline,
                                      color: GlobalConfig.primaryColor,
                                      size: 25),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Bu üyelik kullanılıyor.",
                                    style: kAxiformaRegular17.copyWith(
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 55,
                                  padding: horizontal20 + vertical15,
                                  child: Text(
                                    "${membership.price} TL",
                                    style: kAxiformaRegular17.copyWith(
                                        fontSize: 18),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showSnackBar(context,
                                        "${membership.name} üyeliği seçildi!");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(W(context) * 0.6, 55),
                                    padding: vertical15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: border15,
                                    ),
                                    backgroundColor: GlobalConfig.primaryColor,
                                  ),
                                  child: Text(
                                    "Bu üyeliğe geç",
                                    style: kAxiformaRegular17.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 10)
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
