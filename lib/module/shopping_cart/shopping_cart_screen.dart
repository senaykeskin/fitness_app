import 'package:flutter/material.dart';
import 'index.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final TextEditingController discountController = TextEditingController();
  final BehaviorSubject<bool> discountAppliedSubject =
      BehaviorSubject<bool>.seeded(false);

  double calculateTotalPrice(
      Map<String, int> cartItems, bool isDiscountApplied) {
    double total = 0.0;
    for (var product in productList) {
      if (cartItems.containsKey(product.id)) {
        total += (product.price) * (cartItems[product.id] ?? 1);
      }
    }

    if (isDiscountApplied) {
      total *= 0.9;
    }

    return total;
  }

  void applyDiscountCode() {
    String enteredCode = discountController.text.trim();

    if (enteredCode == "indirim10") {
      discountAppliedSubject.add(true);
    } else {
      showSnackBar(context, "Geçersiz indirim kodu.");
    }
  }

  @override
  void dispose() {
    discountController.dispose();
    discountAppliedSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat("#,##0.00", "tr_TR");

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customAppBar(context, "Sepetim"),
      body: Padding(
        padding: all10,
        child: StreamBuilder<Map<String, int>>(
          stream: cartManager.cartItemsStream,
          builder: (context, snapshot) {
            final cartItems = snapshot.data ?? {};

            if (cartItems.isEmpty) {
              return Center(
                child: Text(
                  "Sepetiniz boş.",
                  style: kAxiformaRegular17,
                ),
              );
            }

            final productsInCart = productList
                .where((product) => cartItems.containsKey(product.id))
                .toList();

            return StreamBuilder<bool>(
              stream: discountAppliedSubject.stream,
              initialData: discountAppliedSubject.value,
              builder: (context, discountSnapshot) {
                final isDiscountApplied = discountSnapshot.data ?? false;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: productsInCart.length,
                        itemBuilder: (context, index) {
                          final item = productsInCart[index];
                          final quantity = cartItems[item.id] ?? 0;
                          final price = item.price;

                          return Container(
                            margin: bottom10,
                            width: W(context),
                            height: H(context) * 0.13,
                            padding: horizontal5 + vertical10,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: GlobalConfig.primaryColor,
                                width: 1,
                              ),
                              borderRadius: border10,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: W(context) * 0.23,
                                  height: W(context) * 0.23,
                                  child: Image.asset(
                                    item.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  padding: horizontal10,
                                  width: W(context) * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style:
                                            kAxiforma18.copyWith(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${formatter.format(price)} ${item.currency}",
                                        style: kAxiformaRegular17.copyWith(
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cartManager.decreaseQuantity(item.id);
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline_outlined,
                                        color: GlobalConfig.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: kAxiformaRegular17.copyWith(
                                          fontSize: 13),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cartManager.increaseQuantity(item.id);
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: GlobalConfig.primaryColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: horizontal10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: border10,
                              border:
                                  Border.all(color: GlobalConfig.primaryColor),
                            ),
                            child: TextField(
                              controller: discountController,
                              decoration: const InputDecoration(
                                hintText: "İndirim kodu giriniz",
                                border: InputBorder.none,
                              ),
                              style: kAxiformaRegular17,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: applyDiscountCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalConfig.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: border10,
                              ),
                            ),
                            child: Text(
                              "Uygula",
                              style: kAxiformaRegular17.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isDiscountApplied) ...[
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "%10 indirim uygulandı.",
                          style: kAxiformaRegular17.copyWith(
                            color: GlobalConfig.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Toplam:",
                          style: kAxiforma18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDiscountApplied
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${formatter.format(calculateTotalPrice(cartItems, false))} ${productList[0].currency}",
                                        style: kAxiformaRegular17.copyWith(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "${formatter.format(calculateTotalPrice(cartItems, true))} ${productList[0].currency}",
                                        style: kAxiforma18.copyWith(
                                          color: GlobalConfig.primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    "${formatter.format(calculateTotalPrice(cartItems, false))} ${productList[0].currency}",
                                    style: kAxiforma18.copyWith(
                                      color: GlobalConfig.primaryColor,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalConfig.primaryColor,
                        fixedSize: Size(W(context), 50),
                        shape: RoundedRectangleBorder(borderRadius: border10),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Sepeti Onayla",
                        style: kAxiformaRegular17.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
