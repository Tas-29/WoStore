import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/models/all-deals-model.dart';
import 'package:netflix/models/category-model.dart';
import 'package:netflix/models/orders-model.dart';
import 'package:netflix/models/product-model.dart';
import 'package:netflix/models/response-model.dart';

class GeneralAPI extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> cartItems = [];
  List<Deals> allDeals = [];
  List<Orders> orders = [];

  Future<ResponseModel> getCategories() async {
    try {
      Response res = await Dio().get(
        API.getCategories,
      );
      if (res.statusCode == 200) {
        print(res.data);
        this.categories =
            List<Category>.from(res.data.map((x) => Category.fromJson(x)));
        return ResponseModel(status: true, message: 'Successfully Done');
      } else {
        return ResponseModel(status: false, message: 'Please, Try Again Later');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  Future<ResponseModel> getProductByCategory({@required categoryId}) async {
    try {
      Response res = await Dio().get(API.getProductsByCategory,
          queryParameters: {'category_id': categoryId});
      if (res.statusCode == 200) {
        print(res.data);
        this.products =
            List<Product>.from(res.data.map((x) => Product.fromJson(x)));
        return ResponseModel(status: true, message: 'Successfully Done');
      } else {
        return ResponseModel(status: false, message: 'Please, Try Again Later');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  Future<ResponseModel> getDealProductById({@required id}) async {
    try {
      Response res = await Dio()
          .get(API.getProductsByCategory, queryParameters: {'deal_id': id});
      if (res.statusCode == 200) {
        print(res.data);
        this.products =
            List<Product>.from(res.data.map((x) => Product.fromJson(x)));
        return ResponseModel(status: true, message: 'Successfully Done');
      } else {
        return ResponseModel(status: false, message: 'Please, Try Again Later');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  Future<ResponseModel> getAllDeals() async {
    try {
      Response res = await Dio().get(
        API.getAllDeals,
      );
      if (res.statusCode == 200) {
        print(res.data);
        this.allDeals =
            List<Deals>.from(res.data.map((x) => Deals.fromJson(x)));
        return ResponseModel(status: true, message: 'Successfully Done');
      } else {
        return ResponseModel(status: false, message: 'Please, Try Again Later');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  Future<ResponseModel> getOrders({@required String customerId}) async {
    try {
      Response res = await Dio()
          .get(API.getOrders, queryParameters: {'customer_id': customerId});
      if (res.statusCode == 200) {
        print(res.data);
        this.orders =
            List<Orders>.from(res.data.map((x) => Orders.fromJson(x)));
        return ResponseModel(status: true, message: 'Successfully Done');
      } else {
        return ResponseModel(status: false, message: 'Please, Try Again Later');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }

  void addProductToCart(Product product, Variant variant) {
    Product newProduct = Product.fromJson(product.toJson());
    newProduct.variant = [variant];
    this.cartItems.add(newProduct);
    notifyListeners();
  }

  void removeProductToCart(int i) {
    this.cartItems.removeAt(i);
    notifyListeners();
  }

  Future<ResponseModel> updatePayment(
      {@required String orderId, @required String paymentId}) async {
    try {
      Response res = await Dio().post(API.updatePayment, data: {
        "order_id": orderId,
        "payment_id": paymentId,
        "date": DateTime.now().toString()
      });
      print(res.data);
      if (res.statusCode == 201) {
        return ResponseModel(status: true, message: 'Successfullly Done');
      } else {
        return ResponseModel(
            status: false, message: 'Something went wrong, please try again.');
      }
    } on DioError catch (e) {
      return ResponseModel(status: false, message: e.response.data['message']);
    }
  }
}
