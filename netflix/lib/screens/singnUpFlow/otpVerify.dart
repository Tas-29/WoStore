import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:netflix/API/customer-api.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/models/response-model.dart';
import 'package:netflix/screens/singnUpFlow/signup-screen2.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerification extends StatefulWidget {
  final String mobileNo;
  OtpVerification({Key key, this.mobileNo}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  String otp;
  ProviderModel providerModel = ProviderModel();
  String enteredOTP;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    return SafeArea(
      child: Scaffold(
        key: sKey,
        backgroundColor: Colors.black.withOpacity(0.9),
        body: LoadingOverlay(
          isLoading: loading,
          color: Colors.white,
          opacity: 0.8,
          progressIndicator: GlobalData().progressIndicatorAsset(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: Text(
                      'We have Sent an OTP to +91${widget.mobileNo.replaceFirst("+91", "")}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Center(
                    child: Text(
                      'Enter the OTP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: GlobalData().grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        bottom: 10.0,
                      ),
                      child: PinFieldAutoFill(
                        codeLength: 4,
                        decoration: UnderlineDecoration(
                            colorBuilder: FixedColorBuilder(Colors.white)),
                        onCodeChanged: (value) {
                          enteredOTP = value.toString();
                          print(value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Center(
                    child: Text(
                      'Didn’t get code yet?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        ResponseModel responseModel =
                            await providerModel.customerAPI.getOtp(widget.mobileNo);
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Text(
                        'Resend OTP',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: GlobalData().red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: FlatButton(
                      color: GlobalData().red,
                      onPressed: () async {
                        print(providerModel.customerAPI.otpRes.otp);
                        print(enteredOTP);
                        if (providerModel.customerAPI.otpRes.otp == enteredOTP) {
                          GlobalData().navigate(
                              context: context, pageName: SignUpScreen2(widget.mobileNo));
                        } else {
                          sKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Your Otp is incorrect.',
                                  textAlign: TextAlign.center),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Verify',
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
    );
  }
}
