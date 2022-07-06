import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Image.network(
            'https://img.freepik.com/free-psd/smartphone-screen-mockup-psd-promotional-ad_53876-123315.jpg?t=st=1650219200~exp=1650219800~hmac=335f557f466ece12e2aaad7123eabcd9ba4038b132c0bf37e8f763c395e3d691&w=740',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
