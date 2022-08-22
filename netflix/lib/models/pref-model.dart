import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:netflix/models/product-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefModel extends ChangeNotifier {
  bool isLogin = false;
  List<Product> likedProducts = [];
  Future<bool> getIsLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isLogin = sharedPreferences.getBool('isLogin') ?? false;
    return isLogin;
  }

  void setIsLogin(bool isLogin) async {
    this.isLogin = isLogin;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLogin', isLogin ?? false);
    notifyListeners();
  }

  void setUserDetails(Map data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('data', data == null ? null : jsonEncode(data));
    notifyListeners();
  }

  Future<Map> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('data') == null
        ? null
        : jsonDecode(sharedPreferences.getString('data'));
  }

  void saveLikedProduct() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        'likedProduct', likedProducts == [] ? [] : jsonEncode(likedProducts));
    notifyListeners();
  }

  Future<bool> getLikedProduct() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('likedProduct') == null) {
      this.likedProducts = [];
    } else {
      this.likedProducts.clear();
      this.likedProducts = List<Product>.from(
          jsonDecode(sharedPreferences.getString('likedProduct'))
              .map((x) => Product.fromJson(x)));
      print(likedProducts);
    }
    return true;
  }
}
