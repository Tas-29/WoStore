import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/models/login-model.dart';
import 'package:netflix/models/otp-model.dart';
import 'package:netflix/models/response-model.dart';

class CustomerAPI extends ChangeNotifier {
  Otp otpRes;
  Login loginRes;
  int orderId;
  Future<ResponseModel> getOtp(String mobile) async {
    try {
      Response res = await Dio().get(
        API.getOtp,
        queryParameters: {"mobile_number": mobile},
      );
      if (res.statusCode == 200) {
        print(res.data);
        this.otpRes = Otp.fromMap(res.data);
        return ResponseModel(status: true, message: 'Successfully Done');
      } else {
        return ResponseModel(status: false, message: 'Please, Try Again Later');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  Future<ResponseModel> register(Map registerData) async {
    try {
      Response res = await Dio().post(API.register, data: registerData);
      if (res.statusCode == 201) {
        this.loginRes = Login.fromMap(res.data);
        return ResponseModel(status: true, message: 'Successfullly Done');
      } else {
        return ResponseModel(
            status: false,
            message: 'Something went wrong, please try again later.');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  Future<ResponseModel> login(
      {@required String mobile, @required String password}) async {
    try {
      Response res = await Dio().post(API.login,
          data: {"mobile_number": mobile, "password": password});
      if (res.statusCode == 201) {
        this.loginRes = Login.fromMap(res.data);
        return ResponseModel(status: true, message: 'Successfullly Done');
      } else {
        return ResponseModel(
            status: false, message: 'Something went wrong, please try again.');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  Future<ResponseModel> createOrder({@required Map data}) async {
    try {
      Response res = await Dio().post(API.createOrder, data: data);
      if (res.statusCode == 201) {
        print(res.data);
        orderId = res.data['id'];
        return ResponseModel(status: true, message: 'Successfullly Created');
      } else {
        return ResponseModel(
            status: false, message: 'Something went wrong, please try again.');
      }
    } on DioError catch (e) {
      print(e);
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }
}
