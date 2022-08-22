import 'package:flutter/material.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class UpiPaymentScreen extends StatefulWidget {
  @override
  _UpiPaymentScreenState createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  List paymentModes = [
    {
      'name': 'BHIM UPI',
      'Image': 'image/bhim.webp',
      'app': 'FlutterUpiApps.BHIMUPI'
    },
    {
      'name': 'GooglePay',
      'Image': 'image/googlePay.webp',
      'app': 'FlutterUpiApps.GooglePay'
    },
    {
      'name': 'PayTM',
      'Image': 'image/payTM.webp',
      'app': 'FlutterUpiApps.PayTM'
    },
    {
      'name': 'PhonePe',
      'Image': 'image/phonePe.webp',
      'app': 'FlutterUpiApps.PhonePe'
    },
    {
      'name': 'MiPay',
      'Image': 'image/miPay.webp',
      'app': 'FlutterUpiApps.MiPay'
    },
    {
      'name': 'AmazonPay',
      'Image': 'image/amazonPay.webp',
      'app': 'FlutterUpiApps.AmazonPay'
    },
    {
      'name': 'TrueCallerUPI',
      'Image': 'image/truecaller.webp',
      'app': 'FlutterUpiApps.TrueCallerUPI'
    },
    {
      'name': 'MyAirtelUPI',
      'Image': 'image/myairtel.webp',
      'app': 'FlutterUpiApps.MyAirtelUPI'
    },
  ];

  ProviderModel providerModel = ProviderModel();
  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    return Scaffold(
      backgroundColor: GlobalData().black,
      appBar: AppBar(
        backgroundColor: GlobalData().black,
        centerTitle: false,
        title: Text('Payment'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: paymentModes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10.0,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () async {
                // UpiFlutter upi = new UpiFlutter(
                //   receiverUpiId: '9694531320@ybl',
                //   receiverName: 'WoStore India',
                //   transactionRefId: 'TestingId',
                //   transactionNote: 'Not actual. Just an example.',
                //   amount: 1.00,
                // );
                // String response = await upi.startTransaction();
                // print(response);
                // String response = await FlutterUpi.initiateTransaction(
                //   app: paymentModes[i]['app'],
                //   pa: "9694531320@ybl",
                //   pn: "Shekhar Kalayna",
                //   tr: "ASDF1234DFG",
                //   tn: "This is a transaction Note",
                //   am: "1",
                //   cu: "INR",
                //   url: "https://www.wostore.in",
                // );
                // FlutterUpiResponse flutterUpiResponse =
                //     FlutterUpiResponse(response);
                // print(flutterUpiResponse.txnId); // prints transaction id
                // print(flutterUpiResponse.txnRef); //prints transaction ref
                // print(flutterUpiResponse.Status); //prints transaction status
                // print(flutterUpiResponse.responseCode); //prints the response code
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  child: Image.asset(
                    paymentModes[i]['Image'],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
