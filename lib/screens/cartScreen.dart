import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/widgets/cart.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "cart_page";
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isInit = true;
  var _isloading = false;
  var _showMessage = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      try {
        await Provider.of<Cart>(context).fetchCart().then((_) {
          setState(() {
            _isloading = false;
          });
        });
      } catch (error) {
        _showMessage = true;
        setState(() {
          _isloading = false;
        });
      }
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cat = Provider.of<Cart>(context, listen: false);
    final catData = cat.cartsItem;
    return Scaffold(
      appBar: AppBar(title: Text("Cart Item")),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: _showMessage
                  ? Center(
                      child: Text("No Cart Item here"),
                    )
                  : ListView.builder(
                      itemCount: catData.length,
                      itemBuilder: ((context, i) => CartWidget(
                          id: catData[i].id,
                          imageUrl: catData[i].imageUrl,
                          siteUrl: catData[i].siteUrl,
                          title: catData[i].title)),
                    ),
            ),
    );
  }
}
