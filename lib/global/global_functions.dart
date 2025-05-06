import 'dart:io';
import 'package:fitness_app/global/global_widgets.dart';
import 'package:fitness_app/module/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../module/my_order/order_manager.dart';
import '../module/products/product_list.dart';
import '../module/settings/language_list.dart';
import '../module/shopping_cart/shopping_cart_manager.dart';
import '../module/widgets/c_tab_bar.dart';

String formatDateTime(DateTime dateTime) {
  final timeFormat = DateFormat.Hm('tr_TR');
  final dateFormat = DateFormat('d MMMM y', 'tr_TR');
  return '${dateFormat.format(dateTime)}\n${timeFormat.format(dateTime)}';
}

String formatDateTimeHorizontal(DateTime dateTime) {
  final timeFormat = DateFormat.Hm('tr_TR');
  final dateFormat = DateFormat('d MMMM y', 'tr_TR');
  return '${dateFormat.format(dateTime)} - ${timeFormat.format(dateTime)}';
}

String formatDateTimeWithoutHour(DateTime dateTime) {
  final dateFormat = DateFormat('d MMMM y', 'tr_TR');
  return dateFormat.format(dateTime);
}

String formatted(DateTime time) => DateFormat('dd/MM - HH:mm').format(time);

Color getProgressColor(double value) {
  if (value <= 0.2) {
    return Colors.red;
  } else if (value <= 0.4) {
    return Colors.deepOrange;
  } else if (value <= 0.6) {
    return Colors.amber;
  } else if (value <= 0.8) {
    return Colors.lightGreen;
  } else {
    return GlobalConfig.primaryColor;
  }
}

void showInfoDialog(BuildContext context, Map<int, int> extras) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: border15),
        backgroundColor: Colors.white,
        child: Padding(
          padding: horizontal20 + vertical15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'İçilen Su Detayı',
                style: kAxiforma18.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              ...[100, 200, 300, 500].map((amount) {
                final count = extras[amount] ?? 0;
                return Padding(
                  padding: vertical5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$amount ml', style: kAxiformaRegular17),
                      Text('$count adet', style: kAxiformaRegular17),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalConfig.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: border10,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Tamam",
                  style: kAxiformaRegular17.copyWith(
                      fontSize: 14, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

void showSuccessAnimation(BuildContext context, String text) {
  final navigator = Navigator.of(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      Future.delayed(const Duration(seconds: 3), () {
        cartManager.clearCart();

        if (navigator.canPop()) {
          navigator.pop();
        }
      });

      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: W(context) * 0.6,
          padding: all20,
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: border15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/animations/successful.json',
                  repeat: false, width: 100, height: 100),
              const SizedBox(height: 5),
              Text(
                text,
                style: kAxiformaRegular17.copyWith(
                    color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.black87}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(message,
          style:
              kAxiformaRegular17.copyWith(fontSize: 15, color: Colors.white)),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: border15,
      ),
    ),
  );
}

ImageProvider? controlImageFromPath(String? path) {
  if (path == null) return null;
  if (path.startsWith("assets/")) {
    return AssetImage(path);
  } else {
    return FileImage(File(path));
  }
}

Future<dynamic> languageBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: verticalTop20,
    ),
    builder: (context) {
      String selectedLanguage = selectedLanguageSubject.value;

      return StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: all15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...languageOptions.map((langOption) {
                bool isSelected = selectedLanguage == langOption.name;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLanguage = langOption.name;
                    });
                    selectedLanguageSubject.add(langOption.name);

                    Navigator.of(context).pushAndRemoveUntil(
                      RouteAnimation.createRoute(
                        CTabbar(showAnimation: true),
                        -1.0,
                        0.0,
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: vertical5,
                    padding: all15,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? GlobalConfig.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: border15,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          langOption.image,
                          width: 40,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          langOption.name,
                          style: kAxiformaRegular17.copyWith(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}

void toggleAmount(int amount, bool isIncrement) {
  final data = Map<int, int>.from(waterSubject.value);
  final current = data[amount] ?? 0;

  if (isIncrement) {
    data[amount] = current + 1;
  } else {
    if (current > 0) data[amount] = current - 1;
  }

  waterSubject.add(data);
}

void orderDetailsBottomSheet(
    BuildContext context, Order order, NumberFormat formatter) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: verticalTop15,
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Padding(
            padding: vertical20 + horizontal20,
            child: ListView(
              controller: scrollController,
              children: [
                Text("Sipariş Numarası: ${order.id}",
                    style: kAxiforma18.copyWith(fontSize: 15)),
                const SizedBox(height: 8),
                Text(
                  "Sipariş Tarihi: ${formatDateTimeHorizontal(order.date)}",
                  style: kAxiformaRegular17.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Text("Ürünler", style: kAxiforma18.copyWith(fontSize: 15)),
                const SizedBox(height: 10),
                ...order.items.entries.map((entry) {
                  final productId = entry.key;
                  final quantity = entry.value;
                  final product =
                      productList.firstWhere((p) => p.id == productId);
                  return Padding(
                    padding: vertical5,
                    child: Row(
                      children: [
                        SizedBox(
                          width: W(context) * 0.15,
                          height: W(context) * 0.15,
                          child: Image.asset(product.image),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style:
                                    kAxiformaRegular17.copyWith(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "$quantity x ${formatter.format(product.price)} ${product.currency}",
                                style: kAxiformaRegular17.copyWith(
                                    fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Toplam tutar: ",
                      style: kAxiforma18.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  TextSpan(
                      text:
                          "${formatter.format(order.total)} ${productList[0].currency}",
                      style: kAxiformaRegular17.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: GlobalConfig.primaryColor,
                      ))
                ])),
              ],
            ),
          );
        },
      );
    },
  );
}
