import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ReturnPolicyScreen extends StatefulWidget {
  @override
  _ReturnPolicyScreenState createState() => _ReturnPolicyScreenState();
}

class _ReturnPolicyScreenState extends State<ReturnPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Hexcolor('#089696'),
        centerTitle: false,
        title: Text(
          'Return Policy',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
