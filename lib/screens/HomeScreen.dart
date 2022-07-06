// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopapp/widgets/header.dart';
import 'package:shopapp/widgets/horizantalList.dart';
import 'package:shopapp/widgets/productGrid.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        //TODO: Use your own custom Icons.
        title: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
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
      //TODO: IF you want to scroll whole page than try singleScrollView.

      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                //TODO: valueKey =>  if you needed in future.
                decoration: InputDecoration(
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
                    suffixIcon: Icon(Icons.search)),
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
