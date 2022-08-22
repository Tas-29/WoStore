import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/login-model.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/screens/main-page-view.dart';
import 'package:netflix/screens/singnUpFlow/signup-screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ProviderModel providerModel = ProviderModel();
  void launchThis() async {
    await providerModel.prefModel.getIsLogin();
    if(providerModel.prefModel.isLogin)
    providerModel.customerAPI.loginRes = Login.fromMap(await providerModel.prefModel.getUserDetails());
    Timer(Duration(seconds: 3), () {
      GlobalData().navigate(context: context, pageName: MainPageView());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
      launchThis();
    }
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: NetworkImage(
      //         'https://www.brisbaneproductphotography.com.au/wp-content/uploads/2016/01/Black-Background-Product-Photography-18-624x468.jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        body: Center(
          child: SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'image/wostorelogo.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
