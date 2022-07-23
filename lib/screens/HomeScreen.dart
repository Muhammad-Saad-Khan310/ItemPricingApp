// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:shopapp/models/productModal.dart';
import 'package:shopapp/widgets/header.dart';
import 'package:shopapp/widgets/horizantalList.dart';
import 'package:shopapp/widgets/productGrid.dart';
import "../widgets/drawer.dart";

class HomeScreen extends StatefulWidget {
  static const routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  var userInput = "";
  var _isLoading = false;

  Future<void> searchProduct() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    await Provider.of<ProdcutsList>(context, listen: false)
        .searchProduct(userInput);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        //TODO: Use your own custom Icons.
        // title: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pushNamed(HomeScreen.routeName);
        //       // HomeScreen();
        //     },
        //     icon: Icon(
        //       Icons.menu,
        //       color: Colors.black,
        //     )),

        backgroundColor: const Color(0xffE5E5E5),
        elevation: 0,
        actions: const [
          // TODO: Wrap with Boutton or Gesture.
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      //TODO: IF you want to scroll whole page than try singleScrollView.

      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              //TODO: valueKey =>  if you needed in future.
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                labelText: 'Search what you need...',
                                fillColor: Colors.white,
                                filled: true,
                                // suffixIcon: Icon(Icons.search)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter product name";
                                }
                                return null;
                              },

                              onSaved: (value) {
                                userInput = value!;
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                searchProduct();
                              },
                              icon: _isLoading
                                  ? CircularProgressIndicator()
                                  : Icon(Icons.search))
                        ],
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       searchProduct();
                    //     },
                    //     child: Text("search item"))
                  ],
                ),
              ),
            ),
            HorizantalList(),
            Header(),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}
