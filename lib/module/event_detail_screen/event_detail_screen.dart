import 'index.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final EventsModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final formatter = formatDateTimeHorizontal(event.date);

    return Scaffold(
      appBar: customAppBar(context, event.title),
      body: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20)),
            child: Image.asset(
              event.image,
              height: H(context) * 0.35,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: all10,
              child: ListView(
                children: [
                  Text(event.title,
                      textAlign: TextAlign.center,
                      style: kAxiforma18.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        formatter,
                        style: kAxiformaRegular17.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.place, size: 18),
                      const SizedBox(width: 8),
                      Text(event.location,
                          style: kAxiformaRegular17.copyWith(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18),
                      const SizedBox(width: 8),
                      Text("Eğitmen: ${event.trainerName}",
                          style: kAxiformaRegular17.copyWith(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Kontenjan: 30",
                        style: kAxiformaRegular17.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  Text(
                    event.description,
                    style:
                        kAxiformaRegular17.copyWith(fontSize: 15, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: horizontal10 + vertical5,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final isRegistered = myEventsSubject.value.contains(event);

                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      isRegistered
                          ? "İptal Etmek İstiyor Musunuz?"
                          : "Etkinliğe Katılmak İstiyor Musunuz?",
                      style: kAxiforma18.copyWith(fontSize: 16),
                    ),
                    content: Text(
                      isRegistered
                          ? "Etkinliğe olan kaydınız iptal edilecektir. Tekrar katılmak"
                              " istediğinizde yeterli kontenjan bulunmayabilir. Onaylıyor musunuz?"
                          : "Bu etkinliğe kaydınız yapılacaktır. Son iptal tarihi, etkinlikten 2 gün öncedir. "
                              "Katılımı onaylıyor musunuz?",
                      style: kAxiformaRegular17.copyWith(fontSize: 15),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          "Vazgeç",
                          style: kAxiformaRegular17.copyWith(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isRegistered
                              ? Colors.red.shade700
                              : GlobalConfig.primaryColor,
                        ),
                        child: Text("Onayla",
                            style: kAxiformaRegular17.copyWith(
                                color: Colors.white, fontSize: 15)),
                      ),
                    ],
                  ),
                );

                if (result == true) {
                  final currentList = myEventsSubject.value;

                  if (isRegistered) {
                    final updatedList =
                        currentList.where((e) => e != event).toList();
                    myEventsSubject.add(updatedList);
                  } else {
                    final updatedList = [...currentList, event];
                    myEventsSubject.add(updatedList);
                  }

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: myEventsSubject.value.contains(event)
                    ? Colors.red.shade700
                    : GlobalConfig.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: border10,
                ),
              ),
              child: Text(
                myEventsSubject.value.contains(event)
                    ? "Katılımı İptal Et"
                    : "Kayıt Ol",
                style: kAxiformaRegular17.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
