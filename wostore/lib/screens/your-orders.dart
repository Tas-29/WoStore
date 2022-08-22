import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/screens/login-screen.dart';
import 'package:netflix/screens/order-details.dart';

class YourOrdersScreen extends StatefulWidget {
  @override
  _YourOrdersScreenState createState() => _YourOrdersScreenState();
}

class _YourOrdersScreenState extends State<YourOrdersScreen> {
  ProviderModel providerModel = ProviderModel();
  bool loading = false;
  void getOrders() async {
    setState(() {
      loading = true;
    });
    await providerModel.generalAPI.getOrders(
        customerId: providerModel.customerAPI.loginRes.id.toString());
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
      if (providerModel.prefModel.isLogin) getOrders();
    }
    return Scaffold(
      backgroundColor:
          !providerModel.prefModel.isLogin ? Colors.white : GlobalData().black,
      appBar: AppBar(
        backgroundColor: GlobalData().black,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Your Orders',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !providerModel.prefModel.isLogin
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset('image/login.png'),
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
                            Icons.lock_open,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Go to Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        bool done = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => LoginScreen()));
                        if (done ?? false) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          : LoadingOverlay(
              isLoading: loading,
              color: Colors.white,
              opacity: 1,
              progressIndicator: GlobalData().progressIndicatorAsset(),
              child: ListView.builder(
                itemCount: providerModel.generalAPI.orders.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      GlobalData().navigate(
                          context: context, pageName: OrderDetailsScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.4),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Column(
                                children: [
                                  Image.network(
                                    API.getImage+providerModel.generalAPI.orders[index].orderProducts[0].variant.imageLinks[0],
                                    scale: 8,
                                    width: 90,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0),
                                    child: Text(
                                      '#87987',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10.0),
                                    child: Text(
                                      'Grey Solid Georgette with Digital printed Border Saree',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Hexcolor('#0FC47E'),
                                          radius: 5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Delivered On July 5, 2020',
                                          style: TextStyle(
                                            color: Hexcolor('#858585'),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
    );
  }
}
