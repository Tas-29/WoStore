import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/screens/product-detail.dart';

class ProductListingScreen extends StatefulWidget {
  final String heading;
  ProductListingScreen({@required this.heading});
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  ProviderModel providerModel = ProviderModel();
  final List a = [
    {
      'image':
          'https://i.pinimg.com/originals/02/ed/98/02ed98fb8fcd176a03b672a4ca656e53.jpg',
      'name': 'Collections'
    },
    {
      'image':
          'https://i.pinimg.com/originals/02/ed/98/02ed98fb8fcd176a03b672a4ca656e53.jpg',
      'name': 'Occasion'
    },
    {
      'image':
          'https://i.pinimg.com/originals/02/ed/98/02ed98fb8fcd176a03b672a4ca656e53.jpg',
      'name': 'Fabric'
    },
    {
      'image':
          'https://i.pinimg.com/originals/02/ed/98/02ed98fb8fcd176a03b672a4ca656e53.jpg',
      'name': 'Work'
    },
    {
      'image':
          'https://i.pinimg.com/736x/07/06/4e/07064eb651414fe0afce30c5e0d213f0.jpg',
      'name': 'Collections'
    },
    {
      'image':
          'https://i.pinimg.com/736x/07/06/4e/07064eb651414fe0afce30c5e0d213f0.jpg',
      'name': 'Occasion'
    },
    {
      'image':
          'https://i.pinimg.com/originals/02/ed/98/02ed98fb8fcd176a03b672a4ca656e53.jpg',
      'name': 'Fabric'
    },
    {
      'image':
          'https://i.pinimg.com/originals/02/ed/98/02ed98fb8fcd176a03b672a4ca656e53.jpg',
      'name': 'Work'
    },
  ];
  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
    }
    return Scaffold(
      backgroundColor: GlobalData().black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GlobalData().black,
        centerTitle: false,
        title: Text(
          widget.heading,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // SizedBox(
          //   width: 35,
          //   child: Icon(Icons.search),
          // ),
          // SizedBox(
          //   width: 35,
          //   child: Icon(Icons.shopping_cart),
          // ),
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: providerModel.generalAPI.products.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  GlobalData().navigate(
                    context: context,
                    pageName: ProductDetailScreen(
                      productDetail: providerModel.generalAPI.products[i],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 2,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) {
                                    return CupertinoActivityIndicator();
                                  },
                                  errorWidget: (context, url, error) {
                                    return Center(child: Icon(Icons.broken_image,size: 50,color: Colors.white,));
                                  },
                                  imageUrl: API.getImage +
                                      providerModel.generalAPI.products[i]
                                          .variant[0].imageLinks[0],
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                providerModel.generalAPI.products[i].name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    '₹${providerModel.generalAPI.products[i].variant[0].price.salePrice}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${providerModel.generalAPI.products[i].variant[0].price.retailPrice}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${(100 - (providerModel.generalAPI.products[i].variant[0].price.salePrice / providerModel.generalAPI.products[i].variant[0].price.retailPrice) * 100).toStringAsFixed(0)}% off',
                                    style: TextStyle(
                                      color: GlobalData().red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // IgnorePointer(
          //   child: Scaffold(
          //     backgroundColor: Colors.transparent,
          //     body: Column(
          //       children: [
          //         Spacer(),
          //         Container(
          //           margin: const EdgeInsets.only(
          //               bottom: 50.0, left: 4.0, right: 4.0),
          //           width: MediaQuery.of(context).size.width,
          //           height: 50,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             border: Border.all(
          //               color: Colors.black.withOpacity(0.2),
          //             ),
          //           ),
          //           child: Row(
          //             children: [
          //               Expanded(
          //                 child: Container(
          //                   child: Center(
          //                       child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Image.asset('image/sort.png'),
          //                       SizedBox(
          //                         width: 20,
          //                       ),
          //                       Text(
          //                         'Sort',
          //                         style: TextStyle(
          //                           color: Colors.black,
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ],
          //                   )),
          //                 ),
          //               ),
          //               VerticalDivider(
          //                 thickness: 1,
          //               ),
          //               Expanded(
          //                 child: Container(
          //                   child: Center(
          //                       child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Image.asset('image/filter.png'),
          //                       SizedBox(
          //                         width: 20,
          //                       ),
          //                       Text(
          //                         'Filter',
          //                         style: TextStyle(
          //                           color: Colors.black,
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ],
          //                   )),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
