import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/models/response-model.dart';
import 'package:netflix/screens/dashboard.dart';
import 'package:netflix/screens/main-page-view.dart';
import 'package:netflix/screens/singnUpFlow/signup-screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  bool show = false;
  ProviderModel providerModel = ProviderModel();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  TextEditingController mobile = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    return Container(
      child: Scaffold(
        key: sKey,
        backgroundColor: Colors.black.withOpacity(0.9),
        body: LoadingOverlay(
          isLoading: loading,
          opacity: 0.8,
          color: Colors.white,
          progressIndicator: GlobalData().progressIndicatorAsset(),
          child: SingleChildScrollView(
            child: Form(
              key: fKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
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
                  Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                          fontSize: 28,
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
                      controller: mobile,
                      keyboardType: TextInputType.phone,
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
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: password,
                      obscureText: !show,
                      validator: (a) {
                        if (a.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          icon: Icon(
                            Icons.visibility_off,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        filled: true,
                        fillColor: GlobalData().grey,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 30.0, top: 16.0, bottom: 30.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: FlatButton(
                      color: GlobalData().red,
                      onPressed: () async {
                        if (fKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          ResponseModel r = await providerModel.customerAPI
                              .login(
                                  mobile: mobile.text.trim(),
                                  password: password.text.trim());
                          setState(() {
                            loading = false;
                          });
                          if (r.status) {
                            providerModel.prefModel.setIsLogin(true);
                            providerModel.prefModel.setUserDetails(
                              providerModel.customerAPI.loginRes.toMap(),
                            );
                            Navigator.pop(context, true);
                          } else {
                            sKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(r.message,
                                    textAlign: TextAlign.center),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        GlobalData().navigate(
                            context: context, pageName: SignUpScreen());
                      },
                      child: RichText(
                        text: new TextSpan(
                          text: 'Dont\'t have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                              text: 'Sign Up',
                              style: new TextStyle(
                                color: GlobalData().red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
    );
  }
}
