import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TermsAndConditionScreen extends StatefulWidget {
  @override
  _TermsAndConditionScreenState createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Hexcolor('#089696'),
        centerTitle: false,
        title: Text(
          'Terms & Condition',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
