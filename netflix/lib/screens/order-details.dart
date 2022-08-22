import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:netflix/globalData/global-data.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalData().black,
      appBar: AppBar(
        backgroundColor: GlobalData().black,
        elevation: 0,
        centerTitle: false,
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
              ),
              child: Text(
                'Order : #87687',
                style: TextStyle(color: Hexcolor('#7F4DC3')),
              ),
            ),
            Divider(
              thickness: 3,
              color: Colors.grey[700],
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                            'https://i.pinimg.com/originals/02/ed/98/02ed98fb8fcd176a03b672a4ca656e53.jpg',
                            scale: 8,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, top: 10.0),
                            child: Text(
                              'Grey Solid Georgette with Digital printed Border Saree',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              '₹1,931',
                              style: TextStyle(
                                color: Hexcolor('#0FC47E'),
                                fontSize: 18,
                              ),
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
            Divider(
              thickness: 3,
              color: Colors.grey[700],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Row(
                children: [
                  Text(
                    'Shipping Details',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.4),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rajesh Sharma',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      '32-B, Vaishali Apartment, New market Road , sector-3 udaipur',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      'Udaipur, Rajasthan - 313001',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      '9876543210',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 3,
              color: Colors.grey[700],
            ),
            SizedBox(
              height: 10,
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
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.3),
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
                          'Price(2 item)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '₹38,620 ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
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
                          '₹38,620 ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
