import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/screens/main-page-view.dart';
import 'package:netflix/screens/your-orders.dart';

class OrderConfirmedScreen extends StatefulWidget {
  @override
  _OrderConfirmedScreenState createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: GlobalData().black,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: Center(
                child: Image.asset(
                  'image/order-completed.png',
                  scale: 4,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'ORDER CONFIRMED',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Thanks for using WoStore. Your order has been Successfully placed.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 55,
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => MainPageView()),
                  (route) => false,
                );
                GlobalData().navigate(
                  context: context,
                  pageName: YourOrdersScreen(),
                );
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Hexcolor('#089696'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Go to Your Orders',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Hexcolor('#089696'), fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
