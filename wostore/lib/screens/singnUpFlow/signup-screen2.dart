import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/models/response-model.dart';
import 'package:netflix/screens/login-screen.dart';
import 'package:netflix/screens/main-page-view.dart';

class SignUpScreen2 extends StatefulWidget {
  final String mobileNo;
  SignUpScreen2(this.mobileNo);

  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  int genderGroupValue = -1;
  bool loading = false;
  ProviderModel providerModel = ProviderModel();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  TextEditingController password = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pinCode = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController localityTown = new TextEditingController();
  TextEditingController cityDistrict = new TextEditingController();
  TextEditingController state = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://www.brisbaneproductphotography.com.au/wp-content/uploads/2016/01/Black-Background-Product-Photography-18-624x468.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: sKey,
        backgroundColor: Colors.black.withOpacity(0.9),
        body: LoadingOverlay(
          color: Colors.white,
          isLoading: loading,
          opacity: 0.8,
          progressIndicator: GlobalData().progressIndicatorAsset(),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: fKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Complete your sign up',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: password,
                        keyboardType: TextInputType.text,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText: 'Create Password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: const EdgeInsets.only(
                          left: 30.0, top: 5.0, right: 30.0),
                      color: GlobalData().grey,
                      child: Center(
                        child: Text(
                          'Minimum 8 Characters',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: name,
                        keyboardType: TextInputType.text,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Gender :',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: genderGroupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      genderGroupValue = value;
                                    });
                                  }),
                              Text('Female')
                            ],
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: genderGroupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      genderGroupValue = value;
                                    });
                                  }),
                              Text('Male')
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: pinCode,
                        keyboardType: TextInputType.number,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText: 'Pin Code',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: address,
                        keyboardType: TextInputType.text,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText:
                              'Address (House No, Building, Street, Area)',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: localityTown,
                        keyboardType: TextInputType.text,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText: 'Locality / Town',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: cityDistrict,
                        keyboardType: TextInputType.text,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText: 'City / District',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: state,
                        keyboardType: TextInputType.text,
                        validator: (a) {
                          if (a.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: GlobalData().grey,
                          labelText: 'State',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: FlatButton(
                        color: GlobalData().red,
                        onPressed: () async {
                          if (fKey.currentState.validate()) {
                            if (genderGroupValue == -1) {
                              sKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please select gender.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } else {
                              if (password.text.length < 8) {
                                sKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Minimum 8 character password should be used.',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                ResponseModel r =
                                    await providerModel.customerAPI.register({
                                  "full_name": name.text.trim(),
                                  "address": address.text.trim(),
                                  "locality": localityTown.text.trim(),
                                  "city": cityDistrict.text.trim(),
                                  "state": state.text.trim(),
                                  "pincode": pinCode.text.trim(),
                                  "mobile_number": widget.mobileNo,
                                  "email": email.text.trim(),
                                  "gender":
                                      genderGroupValue == 1 ? "Female" : "Male",
                                  "password": password.text.trim()
                                });
                                setState(() {
                                  loading = false;
                                });
                                if (r.status) {
                                  providerModel.prefModel.setIsLogin(true);
                                  providerModel.prefModel.setUserDetails(
                                    providerModel.customerAPI.loginRes.toMap(),
                                  );
                                  GlobalData().navigate(
                                      context: context,
                                      pageName: MainPageView());
                                } else {
                                  sKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        r.message,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                          }
                          // GlobalData()
                          //     .navigate(context: context, pageName: MainPageView());
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
