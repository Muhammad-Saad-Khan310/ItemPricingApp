import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class CartModel {
  final String title;
  final String imageUrl;
  final String siteUrl;
  final String itemPrice;
  final String id;
  CartModel(
      {required this.id,
      required this.imageUrl,
      required this.siteUrl,
      required this.itemPrice,
      required this.title});
}

class Cart with ChangeNotifier {
  final String authToken;
  final String userId;

  List<CartModel> _carts = [
    CartModel(
        id: "1",
        imageUrl:
            "https://img.freepik.com/free-psd/smartphone-mockup_1310-812.jpg?t=st=1650219272~exp=1650219872~hmac=18a097585b045ccbff89d8e5f3f57c75a0e9fba9efd8f3c93347adc952afb7fb&w=740",
        siteUrl:
            "https://www.walmart.com/browse/home/ovens-ranges/4044_90548_5776430",
        itemPrice: "34",
        title: "Mobile phone")
  ];
  List<CartModel> get cartsItem {
    return [..._carts];
  }

  Cart({required this.authToken, required this.userId});

  Future<void> fetchCart() async {
    final url = Uri.parse(
        "https://myapp-df670-default-rtdb.firebaseio.com/cartItem/$userId.json?auth=$authToken");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      List<CartModel> loadedItem = [];

      responseData.forEach((itemId, itemData) {
        loadedItem.insert(
            0,
            CartModel(
                id: itemId,
                imageUrl: itemData["imageUrl"],
                itemPrice: itemData["price"],
                siteUrl: itemData["itemSite"],
                title: itemData["title"]));
      });

      _carts = loadedItem;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> AddtoCart(
      String ImageUrl, String title, String Price, String itemSite) async {
    final url = Uri.parse(
        "https://myapp-df670-default-rtdb.firebaseio.com/cartItem/$userId.json?auth=$authToken");
    try {
      final response = await http.post(url,
          body: json.encode({
            'imageUrl': ImageUrl,
            'title': title,
            'price': Price,
            'itemSite': itemSite,
          }));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteCartItem(String id) async {
    final url = Uri.parse(
        "https://myapp-df670-default-rtdb.firebaseio.com/cartItem/$userId/$id.json?auth=$authToken");
    final existingItemIndex = _carts.indexWhere((item) => item.id == id);
    CartModel? existingItem = _carts[existingItemIndex];
    _carts.removeAt(existingItemIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _carts.insert(existingItemIndex, existingItem);
      notifyListeners();
    }
    existingItem = null;
  }
}
