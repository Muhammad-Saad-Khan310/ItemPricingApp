import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/productModal.dart';
import 'package:shopapp/screens/cartScreen.dart';
import 'package:shopapp/screens/product_detailScreen.dart';
import 'package:shopapp/widgets/cart.dart';
import 'package:shopapp/widgets/drawer.dart';

import 'screens/HomeScreen.dart';
import 'screens/authScreen/auth_screen.dart';
import 'models/auth.dart';
import './screens/splashScreen.dart';

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
          ChangeNotifierProxyProvider<Auth, Cart>(
            create: (ctx) => Cart(authToken: "", userId: ""),
            update: (ctx, auth, previousData) =>
                Cart(authToken: auth.token ?? "", userId: auth.userId ?? ""),
          ),
          // ChangeNotifierProvider.value(value: Cart(authToken: '', userId: "")),
          ChangeNotifierProvider(create: (ctx) => ProdcutsList()),
        ],
        child: Consumer<Auth>(
          builder: ((context, auth, _) => MaterialApp(
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
                  CartScreen.routeName: (ctx) => const CartScreen(),
                  // AppDrawer.routeName: (ctx) => AppDrawer(),
                },
                // home: AuthScreen(),
                // ),
                home: auth.isAuth
                    ? HomeScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                                ? SplashScreen()
                                : AuthScreen(),
                      ),
              )),
        ));
  }
}
