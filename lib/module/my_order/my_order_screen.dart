import 'package:flutter/material.dart';
import 'index.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat("#,##0.00", "tr_TR");

    final String orderState = "hazırlanıyor";

    final List<String> orderStates = [
      "alındı",
      "onaylandı",
      "hazırlanıyor",
      "hazır",
      "teslim edildi",
      "iptal edildi",
      "reddedildi"
    ];

    Color orderStateColor(String orderState) {
      if (orderState == orderStates[0]) {
        return Colors.yellow.shade600;
      } else if (orderState == orderStates[1]) {
        return Colors.orange.shade500;
      } else if (orderState == orderStates[2]) {
        return Colors.orange.shade700;
      } else if (orderState == orderStates[3]) {
        return Colors.green;
      } else if (orderState == orderStates[4]) {
        return GlobalConfig.primaryColor;
      } else if (orderState == orderStates[5] || orderState == orderStates[6]) {
        return Colors.red.shade700;
      } else {
        return Colors.grey.shade300;
      }
    }

    return Scaffold(
      appBar: customAppBar(context, "Sipariş Geçmişi"),
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<List<Order>>(
        stream: orderManager.ordersStream,
        builder: (context, snapshot) {
          final orders = snapshot.data ?? [];
          orders.sort((a, b) => b.date.compareTo(a.date));

          if (orders.isEmpty) {
            return Center(
              child: Text(
                "Henüz bir siparişiniz yok.",
                style: kAxiformaRegular17.copyWith(fontSize: 15),
              ),
            );
          }

          return ListView.builder(
            padding: all10,
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderDate = formatDateTimeHorizontal(order.date);
              final orderTotal = order.total;
              final productCount = order.items.length;

              return Container(
                margin: bottom10,
                padding: all10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: border10,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderDate,
                      style: kAxiforma18.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$productCount ürün",
                          style: kAxiformaRegular17.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          "${formatter.format(orderTotal)} ${productList[0].currency}",
                          style: kAxiforma18.copyWith(
                              color: GlobalConfig.primaryColor, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Sipariş durumu: ",
                              style: kAxiformaRegular17.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          TextSpan(
                              text: orderState,
                              style: kAxiformaRegular17.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: orderStateColor(orderState),
                              ))
                        ])),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 2,
                                backgroundColor: Colors.white,
                                padding: horizontal20 + vertical5),
                            onPressed: () => orderDetailsBottomSheet(
                                context, order, formatter),
                            child: Text(
                              "Detay",
                              style: kAxiformaRegular17.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: GlobalConfig.primaryColor),
                            ))
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
