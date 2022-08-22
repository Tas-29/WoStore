import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/screens/main-page-view.dart';
import 'package:netflix/screens/product-detail.dart';

class MyFavourites extends StatefulWidget {
  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  ProviderModel providerModel = ProviderModel();
  void getData() async {
    await providerModel.prefModel.getLikedProduct();
    setState(() {});
    print(providerModel.prefModel.likedProducts);
  }

  @override
  Widget build(BuildContext context) {
    if (providerModel.firstTime) {
      providerModel.firstTime = false;
      providerModel.initialise(context);
      getData();
    }
    return providerModel.prefModel.likedProducts.length == 0
        ? Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset('image/liked.png'),
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
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Continue shopping',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => MainPageView()),
                            (route) => false);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Stack(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: providerModel.prefModel.likedProducts.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      GlobalData().navigate(
                        context: context,
                        pageName: ProductDetailScreen(
                          productDetail:
                              providerModel.prefModel.likedProducts[i],
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
                                        return Center(
                                            child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.white,
                                        ));
                                      },
                                      imageUrl: API.getImage +
                                          providerModel
                                              .prefModel
                                              .likedProducts[i]
                                              .variant[0]
                                              .imageLinks[0],
                                      fit: BoxFit.cover,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0),
                                  child: Text(
                                    providerModel
                                        .prefModel.likedProducts[i].name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '₹${providerModel.prefModel.likedProducts[i].variant[0].price.salePrice}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${providerModel.prefModel.likedProducts[i].variant[0].price.retailPrice}',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 12,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${(100 - (providerModel.prefModel.likedProducts[i].variant[0].price.salePrice / providerModel.prefModel.likedProducts[i].variant[0].price.retailPrice) * 100).toStringAsFixed(0)}% off',
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
            ],
          );
  }
}
