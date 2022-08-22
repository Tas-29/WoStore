import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ShippingPolicyScreen extends StatefulWidget {
  @override
  _ShippingPolicyScreenState createState() => _ShippingPolicyScreenState();
}

class _ShippingPolicyScreenState extends State<ShippingPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Hexcolor('#089696'),
        centerTitle: false,
        title: Text(
          'Shipping Policy',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
