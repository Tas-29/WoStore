import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class GlobalData {
  Hexcolor red = Hexcolor('#D82215');
  Hexcolor grey = Hexcolor('#333333');
  Hexcolor black = Hexcolor('#161616');
  Hexcolor pendingOrder = Hexcolor('#FFB100');
  Hexcolor deliveredOrder = Hexcolor('#0FC47E');

  navigate({context, pageName}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
  }

  progressIndicatorAsset() {
    return SizedBox(
      height: 100,
      child: Lottie.asset('image/progress-indicator.json'),
    );
  }
}
