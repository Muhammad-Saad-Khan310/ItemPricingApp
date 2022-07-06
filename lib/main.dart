import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/productModal.dart';
import 'package:shopapp/screens/product_detailScreen.dart';

import 'screens/HomeScreen.dart';
import 'screens/authScreen/auth_screen.dart';
import 'models/auth.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //     create: (ctx) => VerticalProudutModal(
        //         prodcutPrice: 'Price',
        //         productDesc: 'Description',
        //         productId: 'ProductID',
        //         productImage: 'ProuductImage',
        //         productName: 'ProductName'),),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider(create: (ctx) => ProdcutsList()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop-App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xff5959C4),
            ),
          ),
          routes: {
            AuthScreen.routrName: (ctx) => AuthScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          },
          home: AuthScreen()),
    );
  }
}
