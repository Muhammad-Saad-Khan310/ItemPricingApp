// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:shopapp/models/horizantalProductModal.dart';

class HorizantalList extends StatelessWidget {
  final loadeditems = HorizantalProductsList();

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO: With the help of color adjust sizing accourding to your personal perfrence.
      height: 120,
      // color: Colors.red,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: loadeditems.products.length,
          itemBuilder: (ctx, i) {
            return ListTileItem(
              procuctId: loadeditems.products[i].productId,
              productImage: loadeditems.products[i].productImage,
            );
          }),
    );
  }
}

class ListTileItem extends StatelessWidget {
  final String productImage;
  final String procuctId;

  ListTileItem({required this.productImage, required this.procuctId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: SizedBox(
          height: 67,
          width: 90,
          child: Image.network(
            productImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
