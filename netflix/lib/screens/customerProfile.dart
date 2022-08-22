import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/screens/login-screen.dart';
import 'package:netflix/screens/your-orders.dart';

class CustomerProfile extends StatefulWidget {
  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  ProviderModel providerModel = ProviderModel();
  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    Size size = MediaQuery.of(context).size;
    return !providerModel.prefModel.isLogin
        ? Container(
            color: Colors.white,
            child: Column(
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
            ),
          )
        : ListView(
            children: [
              Container(
                width: size.width,
                color: Colors.deepPurple[700],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          providerModel.customerAPI.loginRes.gender == "Male"
                              ? NetworkImage(
                                  'https://cdn3.vectorstock.com/i/1000x1000/91/32/face-young-man-in-frame-circular-avatar-character-vector-28829132.jpg',
                                )
                              : NetworkImage(
                                  'https://cdn1.vectorstock.com/i/1000x1000/46/55/beautiful-woman-red-hair-in-frame-circular-avatar-vector-28634655.jpg',
                                ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      providerModel.customerAPI.loginRes.fullName,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                providerModel.customerAPI.loginRes.mobileNumber,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                providerModel.customerAPI.loginRes.email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                color: GlobalData().black,
                margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Text(
                        "My Addresses",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Text(
                        providerModel.customerAPI.loginRes.billingAddresses[0]
                                .address +
                            ' ' +
                            providerModel
                                .customerAPI.loginRes.billingAddresses[0].city +
                            ' ' +
                            providerModel
                                .customerAPI.loginRes.billingAddresses[0].state,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 8.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "View More",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurple[400],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                color: GlobalData().black,
                margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Text(
                        "My Orders",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 8.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            GlobalData().navigate(
                              context: context,
                              pageName: YourOrdersScreen(),
                            );
                          },
                          child: Text(
                            "View All Orders",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple[400],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                color: GlobalData().black,
                margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 8.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            GlobalData().navigate(
                              context: context,
                              pageName: YourOrdersScreen(),
                            );
                          },
                          child: Text(
                            "Click Here To Change Password",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple[400],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                color: GlobalData().black,
                margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Text(
                        "Deactivate Account",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 8.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            GlobalData().navigate(
                              context: context,
                              pageName: YourOrdersScreen(),
                            );
                          },
                          child: Text(
                            "Remove Account Permanently",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple[400],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
