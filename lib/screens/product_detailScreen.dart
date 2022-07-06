// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/productModal.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = 'ProductDetailScreen';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final List<Color> aviliableColors = [
    Colors.black,
    Colors.amber,
    Colors.greenAccent,
    Colors.blueAccent
  ];

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final productsData =
        Provider.of<ProdcutsList>(context, listen: false).findById(productId);

    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffE5E5E5),
      //   elevation: 0,
      //   title: Text(
      //     productId,
      //     style: const TextStyle(color: Colors.black),
      //   ),
      // ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //TODO: if you want use slider than you can use carousel_slider: ^4.0.0 package in (pub.dev;
                      SizedBox(
                        height: 330,
                        width: double.infinity,
                        child: Hero(
                          tag: productsData.productId,
                          child: Image.network(
                            productsData.productImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              productsData.productName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '\$${productsData.prodcutPrice}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              productsData.productDesc,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  height: 1.5,
                                  wordSpacing: 1),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Aviliable Colors'),
                                SizedBox(
                                  height: 100,
                                  width: 150,
                                  child: ListView.builder(
                                      itemCount: aviliableColors.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, i) => Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: CircleAvatar(
                                              maxRadius: 10,
                                              minRadius: 10,
                                              backgroundColor:
                                                  aviliableColors[i],
                                            ),
                                          )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 40,
              left: 10,
              child: Container(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                ),
              )),
        ],
      ),
    );
  }
}
