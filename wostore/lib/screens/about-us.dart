import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:netflix/globalData/global-data.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData().black,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
