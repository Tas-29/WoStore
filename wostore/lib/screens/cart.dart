import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/models/response-model.dart';
import 'package:netflix/screens/login-screen.dart';
import 'package:netflix/screens/main-page-view.dart';
import 'package:netflix/screens/upi-payment-screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProviderModel providerModel = ProviderModel();
  int subtotal = 0;
  int totalPaybleAmount = 0;
  bool loading = false;
  calAmount() {
    subtotal = 0;
    for (var i = 0; i < providerModel.generalAPI.cartItems.length; i++) {
      subtotal += providerModel.generalAPI.cartItems[i].quantity *
          providerModel.generalAPI.cartItems[i].variant[0].price.salePrice;
    }
    totalPaybleAmount = subtotal;
  }

  Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_m8JNpqFz7GLeTg',
      'amount': totalPaybleAmount * 100,
      'name': 'WoStore',
      'description':
          'Payment for order id #${providerModel.customerAPI.orderId}',
      'prefill': {
        'contact': providerModel.customerAPI.loginRes.mobileNumber,
        'email': providerModel.customerAPI.loginRes.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(response.paymentId);
    setState(() {
      loading = true;
    });
    ResponseModel r = await providerModel.generalAPI.updatePayment(
        orderId: providerModel.customerAPI.orderId.toString(),
        paymentId: response.paymentId);
    setState(() {
      loading = false;
    });
    if (r.status) {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => MainPageView()),
          (route) => false);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
//     Fluttertoast.showToast(
//     msg: "ERROR: " + response.code.toString() + " - " + response.message,
//     timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    calAmount();
    return Scaffold(
      backgroundColor: providerModel.generalAPI.cartItems.length == 0
          ? Colors.white
          : GlobalData().black,
      appBar: AppBar(
        backgroundColor: GlobalData().black,
        centerTitle: false,
        title: Text('Cart'),
      ),
      body: providerModel.generalAPI.cartItems.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset('image/emptyCart.png'),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 100.0),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8.0),
                    child: FlatButton(
                      color: GlobalData().red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Continue shopping',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => MainPageView()),
                            (route) => false);
                      },
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                LoadingOverlay(
                  isLoading: loading,
                  color: Colors.white,
                  opacity: 1,
                  progressIndicator: GlobalData().progressIndicatorAsset(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: providerModel.generalAPI.cartItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.4),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                  API.getImage +
                                                      providerModel
                                                          .generalAPI
                                                          .cartItems[index]
                                                          .variant[0]
                                                          .imageLinks[0],
                                                  scale: 0.9,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 8.0),
                                                child: SizedBox(
                                                  height: 20,
                                                  child: RichText(
                                                    maxLines: 1,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: providerModel
                                                                  .generalAPI
                                                                  .cartItems[
                                                                      index]
                                                                  .name +
                                                              "  ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        TextSpan(
                                                          text: providerModel
                                                              .generalAPI
                                                              .cartItems[index]
                                                              .variant[0]
                                                              .attributes
                                                              .map((e) => e
                                                                  .split("=")
                                                                  .last)
                                                              .join("-"),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 8.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '₹${providerModel.generalAPI.cartItems[index].variant[0].price.salePrice}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${providerModel.generalAPI.cartItems[index].variant[0].price.retailPrice}',
                                                      style: TextStyle(
                                                        color:
                                                            Hexcolor('#858585'),
                                                        fontSize: 16,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${(100 - (providerModel.generalAPI.cartItems[index].variant[0].price.salePrice / providerModel.generalAPI.cartItems[index].variant[0].price.retailPrice) * 100).toStringAsFixed(0)}% off',
                                                      style: TextStyle(
                                                        color:
                                                            Hexcolor('#089696'),
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 8.0),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          if (providerModel
                                                                  .generalAPI
                                                                  .cartItems[
                                                                      index]
                                                                  .quantity >
                                                              1) {
                                                            providerModel
                                                                .generalAPI
                                                                .cartItems[
                                                                    index]
                                                                .quantity--;
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Image.asset(
                                                            'image/minus.png')),
                                                    SizedBox(
                                                      width: 40,
                                                      child: Center(
                                                          child: Text(
                                                        providerModel
                                                            .generalAPI
                                                            .cartItems[index]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          if (providerModel
                                                                  .generalAPI
                                                                  .cartItems[
                                                                      index]
                                                                  .quantity <
                                                              5) {
                                                            providerModel
                                                                .generalAPI
                                                                .cartItems[
                                                                    index]
                                                                .quantity++;
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Image.asset(
                                                            'image/plus.png')),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 0.4,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            providerModel.generalAPI
                                                .removeProductToCart(index);
                                          },
                                          child: Container(
                                            width: 130,
                                            margin: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.6,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                'REMOVE',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Payable Amount: ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 4.0),
                                          child: Text(
                                            '₹${providerModel.generalAPI.cartItems[index].quantity * providerModel.generalAPI.cartItems[index].variant[0].price.salePrice} ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Price Details',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.4),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Subtotal',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '₹$subtotal ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Delivery',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Free ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Hexcolor('#089696'),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.4,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Total Payable',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '₹$totalPaybleAmount ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 50.0),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8.0),
                              child: FlatButton(
                                  color: GlobalData().red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Proceed to checkout',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (!providerModel.prefModel.isLogin) {
                                      bool done = await Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                      if (done ?? false) {
                                        setState(() {});
                                      }
                                    } else {
                                      setState(() {
                                        loading = true;
                                      });
                                      Map data = {};
                                      data["date"] = DateTime.now().toString();
                                      data["customer_id"] =
                                          providerModel.customerAPI.loginRes.id;
                                      data["payment_status"] = "Pending";
                                      data["delivery_status"] = "Pending";
                                      data["order_status"] = "Pending";
                                      data["discount"] = 0;
                                      data["total"] = subtotal;
                                      data["payable_amount"] =
                                          totalPaybleAmount;
                                      data["billing_address_id"] = providerModel
                                          .customerAPI
                                          .loginRes
                                          .billingAddresses[0]
                                          .id;
                                      data["order_products"] = List.from(
                                          providerModel.generalAPI.cartItems
                                              .map((e) => {
                                                    "product_id": e.id,
                                                    "unit_price": e.variant[0]
                                                        .price.salePrice,
                                                    "quantity": e.quantity,
                                                    "total": e.quantity *
                                                        e.variant[0].price
                                                            .salePrice,
                                                    "variant_id":
                                                        e.variant[0].id,
                                                  }));
                                      setState(() {
                                        loading = false;
                                      });
                                      ResponseModel r = await providerModel
                                          .customerAPI
                                          .createOrder(data: data);
                                      if (r.status) {
                                        openCheckout();
                                      } else {}
                                    }
                                  })),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
