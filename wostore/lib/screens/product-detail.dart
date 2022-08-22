import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/pref-model.dart';
import 'package:netflix/models/product-model.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product productDetail;
  ProductDetailScreen({@required this.productDetail});
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  Variant varient;
  List<String> selected = [];
  ProviderModel providerModel = ProviderModel();
  bool liked = false;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.productDetail.variantMapping.length; i++) {
      selected.add(widget.productDetail.variantMapping[i]
          .split('=')
          .last
          .split(';')
          .first);
    }
    varient = widget.productDetail.variant.firstWhere((e) {
      List<bool> a = [];
      for (var i = 0; i < selected.length; i++) {
        print(e.attributes[i].split('=').last);
        print(selected[i]);
        a.add(e.attributes[i].split('=').last == selected[i]);
      }
      print(a);
      return !a.contains(false);
    });
    print(varient.isActive);
  }

  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
      liked = providerModel.prefModel.likedProducts
          .map((e) => e.id)
          .contains(widget.productDetail.id);
    }
    return Scaffold(
      key: sKey,
      backgroundColor: GlobalData().black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GlobalData().black,
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () {
              if (liked) {
                providerModel.prefModel.likedProducts
                    .removeWhere((e) => e.id == widget.productDetail.id);
                providerModel.prefModel.saveLikedProduct();
                setState(() {
                  liked = false;
                });
              } else {
                providerModel.prefModel.likedProducts.add(widget.productDetail);
                providerModel.prefModel.saveLikedProduct();
                setState(() {
                  liked = true;
                });
              }
            },
            child: SizedBox(
              width: 45,
              child: Icon(
                liked ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: GlobalData().red,
              ),
            ),
          ),
          // SizedBox(
          //   width: 35,
          //   child: Icon(Icons.shopping_cart),
          // ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: List.generate(
                    varient.imageLinks.length,
                    (i) {
                      return CachedNetworkImage(
                        imageUrl: API.getImage + varient.imageLinks[i],
                        placeholder: (context, url) {
                          return CupertinoActivityIndicator();
                        },
                        errorWidget: (context, url, error) {
                          return Center(
                              child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.white,
                          ));
                        },
                      );
                    },
                  ),
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 0.7,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.productDetail.variantMapping.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                                    widget.productDetail.variantMapping[index]
                                        .split('=')
                                        .first,
                                    style: TextStyle(color: Colors.white),
                                  ),
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, e) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    selected[index] = widget
                                        .productDetail.variantMapping[index]
                                        .split('=')
                                        .last
                                        .split(';')[e];
                                    varient = widget.productDetail.variant
                                        .firstWhere((e) {
                                      List<bool> a = [];
                                      for (var i = 0;
                                          i < selected.length;
                                          i++) {
                                        print(e.attributes[i].split('=').last);
                                        print(selected[i]);
                                        a.add(e.attributes[i].split('=').last ==
                                            selected[i]);
                                      }
                                      print(a);
                                      return !a.contains(false);
                                    });
                                    print(varient.id);
                                    setState(() {});
                                  },
                                  color: selected.contains(widget
                                          .productDetail.variantMapping[index]
                                          .split('=')
                                          .last
                                          .split(';')[e])
                                      ? GlobalData().red
                                      : GlobalData().grey,
                                  child: Text(widget
                                      .productDetail.variantMapping[index]
                                      .split('=')
                                      .last
                                      .split(';')[e]),
                                ),
                              );
                            },
                            itemCount: widget.productDetail.variantMapping[index]
                                .split('=')
                                .last
                                .split(';')
                                .length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                  child: Text(
                    widget.productDetail.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                widget.productDetail.attributes.length == 0
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                        child: Text(
                          widget.productDetail.attributes
                              .join('\n')
                              .replaceAll('=', ': '),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    children: [
                      Text(
                        '₹${varient.price.salePrice}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '₹${varient.price.retailPrice}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          decorationStyle: TextDecorationStyle.solid,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${(100 - (varient.price.salePrice / varient.price.retailPrice) * 100).toStringAsFixed(0)}% off',
                        style: TextStyle(
                          color: GlobalData().red,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.share,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'SKU: WS${varient.id}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        varient.isActive ? 'In stock' : 'Out of stock',
                        style: TextStyle(
                          color: varient.isActive
                              ? Hexcolor('#089696')
                              : GlobalData().red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    widget.productDetail.description.value,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 30,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 16.0,
                //   ),
                //   child: Row(
                //     children: [
                //       Text(
                //         'Details',
                //         style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         'Saree Color',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16,
                //         ),
                //       ),
                //       Spacer(),
                //       Text(
                //         'Grey',
                //         style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                //   child: Divider(
                //     color: Colors.grey[300],
                //     thickness: 1,
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         'Blouse Color',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16,
                //         ),
                //       ),
                //       Spacer(),
                //       Text(
                //         'Multicolor',
                //         style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                //   child: Divider(
                //     color: Colors.grey[300],
                //     thickness: 1,
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         'Saree Fabric',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16,
                //         ),
                //       ),
                //       Spacer(),
                //       Text(
                //         'Semi Georgette',
                //         style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                //   child: Divider(
                //     color: Colors.grey[300],
                //     thickness: 1,
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         'Blouse Fabric',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16,
                //         ),
                //       ),
                //       Spacer(),
                //       Text(
                //         'Banglori Satin',
                //         style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SafeArea(
                  child: !varient.isActive
                      ? Center(
                          child: Text(
                            'Out of stock',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: GlobalData().red,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(bottom: 100.0),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          color: GlobalData().black,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8.0),
                            child: FlatButton(
                              color: GlobalData().red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                providerModel.generalAPI.addProductToCart(
                                    widget.productDetail, varient);
                                sKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Product added to cart',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
