// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/productModal.dart';
import '../models/cart.dart';

import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = 'ProductDetailScreen';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var _isLoading = false;
  var _addedToCart = false;
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

    Future<void> _saveData() async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Cart>(context, listen: false).AddtoCart(
          productsData.productImage,
          productsData.productName,
          productsData.prodcutPrice,
          productsData.productId);
      _addedToCart = true;

      setState(() {
        _isLoading = false;
      });
    }

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
                          child: GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(productId);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw "Invalid url link";
                              }
                            },
                            child: Image.network(
                              productsData.productImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productsData.productName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                _isLoading
                                    ? CircularProgressIndicator()
                                    : IconButton(
                                        onPressed: () {
                                          _saveData();
                                        },
                                        icon: _addedToCart
                                            ? Icon(Icons.shopping_cart)
                                            : Icon(
                                                Icons.shopping_cart_outlined))
                              ],
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
                            // Column(
                            //   children: [
                            //     Text(
                            //       "Description",
                            //       style: TextStyle(fontWeight: FontWeight.bold),
                            //     ),
                            //     SizedBox(
                            //       height: 10,
                            //     ),
                            //     Text(productsData.productDesc),
                            //   ],
                            // )
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Text('Aviliable Colors'),
                            //     SizedBox(
                            //       height: 100,
                            //       width: 150,
                            //       child: ListView.builder(
                            //           itemCount: aviliableColors.length,
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (ctx, i) => Padding(
                            //                 padding: const EdgeInsets.all(5),
                            //                 child: CircleAvatar(
                            //                   maxRadius: 10,
                            //                   minRadius: 10,
                            //                   backgroundColor:
                            //                       aviliableColors[i],
                            //                 ),
                            //               )),
                            //     ),
                            //   ],
                            // )
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
