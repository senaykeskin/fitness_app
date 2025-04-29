import 'index.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  void _addToCart(BuildContext context, String productId) {
    cartManager.addToCart(productId);
  }

  void _removeFromCart(BuildContext context, String productId) {
    cartManager.decreaseQuantity(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: top10 + horizontal10,
          child: SizedBox(
            width: W(context),
            height: H(context),
            child: Column(
              children: [
                StreamBuilder<Map<String, int>>(
                  stream: cartManager.cartItemsStream,
                  builder: (context, snapshot) {
                    final totalCartItemTypes = snapshot.data?.length ?? 0;

                    return Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                RouteAnimation.createRoute(
                                    ShoppingCartScreen(), 1.0, 0.0),
                              );
                            },
                            child: Container(
                              margin: horizontal10,
                              child: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                          if (totalCartItemTypes > 0)
                            Positioned(
                              right: 5,
                              top: 5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    RouteAnimation.createRoute(
                                        ShoppingCartScreen(), 1.0, 0.0),
                                  );
                                },
                                child: Container(
                                  padding: all5,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '$totalCartItemTypes',
                                    style: kAxiformaRegular17.copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: vertical10,
                        child: Text(
                          "Satın aldığınız ürünleri mağazadan teslim alabilirsiniz.",
                          textAlign: TextAlign.center,
                          style: kAxiformaRegular17.copyWith(fontSize: 15),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<Map<String, int>>(
                          stream: cartManager.cartItemsStream,
                          builder: (context, snapshot) {
                            final cartItems = snapshot.data ?? {};

                            return GridView.builder(
                              padding: bottom15,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                final ProductModel item = productList[index];
                                final formattedPrice =
                                    NumberFormat("#,##0.00", "tr_TR")
                                        .format(item.price);
                                final quantityInCart = cartItems[item.id] ?? 0;

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: border15,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(50),
                                        blurRadius: 5,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        padding: vertical5 + horizontal10,
                                        decoration: BoxDecoration(
                                          borderRadius: topBorder15,
                                          color: GlobalConfig.primaryColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: W(context) / 2 - 90,
                                              alignment: Alignment.center,
                                              child: Text(
                                                item.title,
                                                style: kAxiforma18.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                productDetailBottomSheet(
                                                    context, item, context);
                                              },
                                              icon: const Icon(
                                                Icons.info_outline_rounded,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Container(
                                              padding: all10,
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                item.image,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            if (quantityInCart > 0)
                                              Positioned(
                                                right: 0,
                                                top: 1,
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: border30,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 6,
                                                        color: Colors.black26,
                                                      )
                                                    ],
                                                  ),
                                                  child: Text(
                                                    '$quantityInCart',
                                                    style: kAxiformaRegular17
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: horizontal10 + bottom5 + top10,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "$formattedPrice ${item.currency}",
                                              style: kAxiforma18.copyWith(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: quantityInCart > 0
                                                      ? () => _removeFromCart(
                                                          context, item.id)
                                                      : null,
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  child: Icon(
                                                    Icons
                                                        .remove_circle_outline_rounded,
                                                    size: 26,
                                                    color: quantityInCart > 0
                                                        ? GlobalConfig
                                                            .primaryColor
                                                        : Colors.grey.shade300,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                GestureDetector(
                                                  onTap: () => _addToCart(
                                                      context, item.id),
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  child: Icon(
                                                    Icons
                                                        .add_circle_outline_rounded,
                                                    size: 26,
                                                    color: GlobalConfig
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
