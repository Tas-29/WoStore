import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/screens/about-us.dart';
import 'package:netflix/screens/cart.dart';
import 'package:netflix/screens/customerProfile.dart';
import 'package:netflix/screens/dashboard.dart';
import 'package:netflix/screens/my-favourites.dart';
import 'package:netflix/screens/policies/policies.dart';
import 'package:netflix/screens/search-screen.dart';
import 'package:netflix/screens/singnUpFlow/signup-screen.dart';
import 'package:netflix/screens/upi-payment-screen.dart';
import 'package:netflix/screens/your-orders.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  ProviderModel providerModel = ProviderModel();
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  List<Widget> pages = [
    Dashboard(),
    SearchScreen(),
    MyFavourites(),
    CustomerProfile()
  ];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    return WillPopScope(
      onWillPop: () async {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              actions: [
                CupertinoDialogAction(
                  child: Text('Okay'),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
              content: Text(
                'Do you really want to Quit this app',
              ),
            );
          },
        );
        return true;
      },
      child: Scaffold(
        key: sKey,
        drawer: Drawer(
          child: Container(
            color: GlobalData().black,
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            'image/wostorelogo.png',
                            scale: 1.5,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Home',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 25,
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Your Account',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 18,
                    //             color: Colors.white),
                    //       ),
                    //       Spacer(),
                    //       Icon(
                    //         Icons.arrow_forward_ios,
                    //         color: Colors.white,
                    //         size: 16,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        GlobalData().navigate(
                            context: context, pageName: YourOrdersScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Your Orders',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        GlobalData().navigate(
                            context: context, pageName: AboutUsScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'About Us',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        GlobalData().navigate(
                            context: context, pageName: PoliciesScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Policies',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Help & Support',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                !providerModel.prefModel.isLogin
                    ? SizedBox.shrink()
                    : Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              providerModel.prefModel.setIsLogin(false);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPageView(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Container(
                              width: 130,
                              margin: const EdgeInsets.only(bottom: 50.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.5, color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Log Out',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: GlobalData().black,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              sKey.currentState.openDrawer();
            },
            child: Image.asset(
              'image/menuIcon.png',
              scale: 1.8,
            ),
          ),
          title: Image.asset('image/wostorelogo.png'),
          actions: [
            providerModel.generalAPI.cartItems.length == 0
                ? IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      GlobalData()
                          .navigate(context: context, pageName: CartScreen());
                    },
                  )
                : Badge(
                    position: BadgePosition.topRight(top: 0, right: 0),
                    badgeContent: Text(
                        providerModel.generalAPI.cartItems.length.toString(),
                        style: TextStyle(color: Colors.white)),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        GlobalData()
                            .navigate(context: context, pageName: CartScreen());
                      },
                    ),
                  ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: IndexedStack(
          children: pages,
          index: i,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: i,
          onTap: (value) {
            setState(() {
              i = value;
            });
          },
          backgroundColor: GlobalData().black,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: GlobalData().red),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
