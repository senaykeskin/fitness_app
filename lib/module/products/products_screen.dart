import 'package:flutter/material.dart';
import 'index.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: top50,
          child: SizedBox(
            width: W(context),
            height: H(context),
            child: Column(
              children: [
                Text(
                  "Satın aldığınız ürünleri mağazadan teslim alabilirsiniz.",
                  textAlign: TextAlign.center,
                  style: kAxiformaRegular17.copyWith(fontSize: 15),
                ),
                Expanded(
                  child: GridView.builder(
                      padding: top25 + horizontal10 + bottom15,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final item = productList[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: border15,
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: vertical5 + horizontal10,
                                width: W(context),
                                decoration: BoxDecoration(
                                  borderRadius: topBorder15,
                                  color: GlobalConfig.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: horizontal5 + vertical5,
                                      width: W(context) / 2 - 65,
                                      child: Text(
                                        item["title"],
                                        textAlign: TextAlign.center,
                                        style: kAxiforma18.copyWith(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ),
                                    IconButton(
                                        style: ButtonStyle(
                                          padding:
                                              WidgetStateProperty.all(zero),
                                          minimumSize: WidgetStateProperty.all(
                                              Size(25, 25)),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                        onPressed: () {
                                          productDetailBottomSheet(
                                              context, item);
                                        },
                                        icon: Icon(
                                          Icons.info_outline_rounded,
                                          size: 25,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                margin: top10,
                                height: H(context) * 0.15,
                                child: Image.asset(
                                  item["image"],
                                  width: W(context),
                                  alignment: Alignment.center,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: bottom5 + horizontal10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${item["price"].toString()} ${item["currency"]}",
                                      style: kAxiforma18.copyWith(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                        style: ButtonStyle(
                                            padding:
                                                WidgetStateProperty.all(zero)),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add_circle_rounded,
                                          color: GlobalConfig.primaryColor,
                                          size: 35,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
