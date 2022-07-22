import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart.dart';

class CartWidget extends StatelessWidget {
  // const CartWidget({Key? key}) : super(key: key);
  final String imageUrl;
  final String title;
  final String id;
  final String siteUrl;

  CartWidget(
      {required this.id,
      required this.imageUrl,
      required this.siteUrl,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height * 0.1,
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.18),
              blurRadius: 5,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: NetworkImage(imageUrl),
              height: height * 0.1,
              width: width * 0.25,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            IconButton(
                onPressed: () {
                  Provider.of<Cart>(context, listen: false).deleteCartItem(id);
                },
                icon: Icon(
                  Icons.delete_forever,
                  size: 25,
                ))
          ],
        ));
  }
}
