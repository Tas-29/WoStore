import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/models/response-model.dart';
import 'package:netflix/screens/login-screen.dart';
import 'package:netflix/screens/main-page-view.dart';
import 'package:netflix/screens/singnUpFlow/otpVerify.dart';
import 'package:netflix/screens/singnUpFlow/signup-screen2.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ProviderModel providerModel = ProviderModel();
  TextEditingController mobileNumber = TextEditingController();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  bool loading = false;
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
          color: Colors.white,
          opacity: 0.8,
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
                      'Sign Up',
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
                      controller: mobileNumber,
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 50.0),
                      child: Text(
                        'An Otp will be sent to your mobile number.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                          ResponseModel responseModel = await providerModel
                              .customerAPI
                              .getOtp(mobileNumber.text);
                          setState(() {
                            loading = false;
                          });
                          if (responseModel.status) {
                            GlobalData().navigate(
                                context: context,
                                pageName: OtpVerification(
                                  mobileNo: mobileNumber.text,
                                ));
                          } else {
                            sKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  responseModel.message,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        'Sign Up',
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
                      onTap: () async {
                        bool done = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => LoginScreen()));
                        if (done ?? false) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => MainPageView()),
                              (route) => false);
                        }
                      },
                      child: RichText(
                        text: new TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                              text: 'Log In',
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
