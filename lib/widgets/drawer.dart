import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/HomeScreen.dart';
import 'package:shopapp/screens/authScreen/auth_screen.dart';
import '../models/auth.dart';
import '../screens/cartScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Update the state of the app.
                Navigator.of(context).pushReplacementNamed('homeScreen');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: const Text('Account'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('AuthScreen');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
              ),
              title: const Text('Cart Items'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.of(context).popAndPushNamed(CartScreen.routeName);
                // Navigator.of(context)
                //     .pushReplacementNamed(CartScreen.routeName);
              },
            ),
            authData.isAuth
                ? ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: const Text("Logout"),
                    onTap: () {
                      Navigator.of(context).pushNamed(AuthScreen.routrName);
                      authData.logout();
                    })
                : Container()
          ],
        ),
      ),
    );
  }
}
