import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/screens/product-listing.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalData().black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 10.0, top: 10.0),
            child: Text(
              'Search',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
                style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  'Results (32)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, bottom: 20.0),
          //   child: Text(
          //     'Recently',
          //     style: TextStyle(color: Hexcolor('#858585')),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //   child: Row(
          //     children: [
          //       Text(
          //         'Yamaha Bikes',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       Spacer(),
          //       Image.asset(
          //         'image/arrow.png',
          //         scale: 1.3,
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //   child: Divider(
          //     height: 25,
          //     color: Hexcolor('#D0D0D0'),
          //     thickness: 0.7,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          //   child: Row(
          //     children: [
          //       Text(
          //         'Suzuki Bikes',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       Spacer(),
          //       Image.asset(
          //         'image/arrow.png',
          //         scale: 1.3,
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //   child: Divider(
          //     height: 25,
          //     color: Hexcolor('#D0D0D0'),
          //     thickness: 0.7,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          //   child: Row(
          //     children: [
          //       Text(
          //         'Honda crv',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       Spacer(),
          //       Image.asset(
          //         'image/arrow.png',
          //         scale: 1.3,
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //   child: Divider(
          //     height: 25,
          //     color: Hexcolor('#D0D0D0'),
          //     thickness: 0.7,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          //   child: Row(
          //     children: [
          //       Text(
          //         'Ford Aspire',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       Spacer(),
          //       Image.asset(
          //         'image/arrow.png',
          //         scale: 1.3,
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //   child: Divider(
          //     height: 25,
          //     color: Hexcolor('#D0D0D0'),
          //     thickness: 0.7,
          //   ),
          // )
        ],
      )),
    );
  }
}
