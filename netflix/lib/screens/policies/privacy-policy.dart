import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Hexcolor('#089696'),
        centerTitle: false,
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
