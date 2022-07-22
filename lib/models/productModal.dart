// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class ProductModal {
  final String productId;
  final String productImage;
  final String productName;
  final String productDesc;
  final String prodcutPrice;

  ProductModal(
      {required this.productImage,
      required this.productName,
      required this.productId,
      required this.prodcutPrice,
      required this.productDesc});
}

class ProdcutsList with ChangeNotifier {
  List<ProductModal> _products = [
    ProductModal(
        productName: 'Product1',
        productId: '1',
        productImage:
            'https://img.freepik.com/free-psd/smartphone-mockup_1310-812.jpg?t=st=1650219272~exp=1650219872~hmac=18a097585b045ccbff89d8e5f3f57c75a0e9fba9efd8f3c93347adc952afb7fb&w=740',
        prodcutPrice: '69',
        productDesc:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ut ipsum ligula. Fusce iaculis, erat quis fermentum hendrerit, turpis est aliquet diam, non fermentum nisi neque at lorem. Phasellus eu ipsum nec felis vestibulum fringilla nec at purus. Mauris bibendum luctus neque a porta. Integer in mollis nisl, vel feugiat diam.'),
    // ProductModal(
    //     productName: 'Product10',
    //     productId: '10',
    //     productImage:
    //         'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    //     prodcutPrice: '67',
    //     productDesc: 'This is worst phone in this world just kidding'),
    // ProductModal(
    //     productName: 'Product2',
    //     productId: '2',
    //     productImage:
    //         'https://img.freepik.com/free-psd/smartphone-mockup_1310-812.jpg?t=st=1650219272~exp=1650219872~hmac=18a097585b045ccbff89d8e5f3f57c75a0e9fba9efd8f3c93347adc952afb7fb&w=740',
    //     prodcutPrice: '79',
    //     productDesc: 'This is worst phone in this world just kidding'),
    // ProductModal(
    //     productName: 'Product3',
    //     productId: '3',
    //     productImage:
    //         'https://img.freepik.com/free-psd/smartphone-mockup_1310-812.jpg?t=st=1650219272~exp=1650219872~hmac=18a097585b045ccbff89d8e5f3f57c75a0e9fba9efd8f3c93347adc952afb7fb&w=740',
    //     prodcutPrice: '9',
    //     productDesc: 'This is worst phone in this world just kidding'),
    // ProductModal(
    //     productName: 'Product4',
    //     productId: '4',
    //     productImage:
    //         'https://img.freepik.com/free-psd/smartphone-mockup_1310-812.jpg?t=st=1650219272~exp=1650219872~hmac=18a097585b045ccbff89d8e5f3f57c75a0e9fba9efd8f3c93347adc952afb7fb&w=740',
    //     prodcutPrice: '679',
    //     productDesc:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ut ipsum ligula. Fusce iaculis, erat quis fermentum hendrerit, turpis est aliquet diam, non fermentum nisi neque at lorem. Phasellus eu ipsum nec felis vestibulum fringilla nec at purus. Mauris bibendum luctus neque a porta. Integer in mollis nisl, vel feugiat diam.'),
    // ProductModal(
    //     productName: 'Product5',
    //     productId: '5',
    //     productImage:
    //         'https://img.freepik.com/free-psd/smartphone-mockup_1310-812.jpg?t=st=1650219272~exp=1650219872~hmac=18a097585b045ccbff89d8e5f3f57c75a0e9fba9efd8f3c93347adc952afb7fb&w=740',
    //     prodcutPrice: '679',
    //     productDesc:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ut ipsum ligula. Fusce iaculis, erat quis fermentum hendrerit, turpis est aliquet diam, non fermentum nisi neque at lorem. Phasellus eu ipsum nec felis vestibulum fringilla nec at purus. Mauris bibendum luctus neque a porta. Integer in mollis nisl, vel feugiat diam.'),
    // ProductModal(
    //     productName: 'Product6',
    //     productId: '6',
    //     productImage:
    //         'https://img.freepik.com/free-psd/phone-screen-ui-ux-app-presentation-mockup_165789-302.jpg?t=st=1650219272~exp=1650219872~hmac=cb31b0666d7da7a94acbefffececa7883ae5d3c3e94d834125a8beafe4e6b9ff&w=740',
    //     prodcutPrice: '679',
    //     productDesc:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ut ipsum ligula. Fusce iaculis, erat quis fermentum hendrerit, turpis est aliquet diam, non fermentum nisi neque at lorem. Phasellus eu ipsum nec felis vestibulum fringilla nec at purus. Mauris bibendum luctus neque a porta. Integer in mollis nisl, vel feugiat diam.'),
  ];
  List<ProductModal> get productsItem {
    return [..._products];
  }

  ProductModal findById(String productid) {
    return productsItem.firstWhere((product) => product.productId == productid);
  }

  Future<void> searchProduct(String query) async {
    final searchUrl = "https://price-scraper.herokuapp.com/products/search?q=" +
        query +
        " price";
    final url = Uri.parse(searchUrl);
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    List<ProductModal> loadedItem = [];
    responseData.forEach((itemData) {
      loadedItem.insert(
          0,
          ProductModal(
              productImage: itemData["image"],
              productName: query,
              productId: itemData["link"],
              prodcutPrice: itemData["price"],
              productDesc: itemData["description"]));
      _products = loadedItem;
      print(itemData['price']);
      notifyListeners();
    });
    // print(responseData);
  }

  Future<void> FetchProduct() async {
    var lst = [
      "oppo",
      "perfumes",
      "oven",
      "iphone",
    ];
    List<ProductModal> loadedItem = [];
    for (var i = 0; i < lst.length; i++) {
      var query = lst[i];
      final searchUrl =
          "https://price-scraper.herokuapp.com/products/search?q=" +
              query +
              " price";
      final url = Uri.parse(searchUrl);
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      responseData.forEach((itemData) {
        loadedItem.insert(
            0,
            ProductModal(
                productImage: itemData["image"],
                productName: query,
                productId: itemData["link"],
                prodcutPrice: itemData["price"],
                productDesc: itemData["description"]));
      });
      // _products = loadedItem;

      // print(responseData);
    }
    _products = loadedItem;
    notifyListeners();
  }
}
