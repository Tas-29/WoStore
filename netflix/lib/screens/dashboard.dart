import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:netflix/API/api.dart';
import 'package:netflix/globalData/global-data.dart';
import 'package:netflix/models/provider-model.dart';
import 'package:netflix/models/response-model.dart';
import 'package:netflix/screens/product-detail.dart';
import 'package:netflix/screens/product-listing.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProviderModel providerModel = ProviderModel();
  bool loading = true;
  void getData() async {
    await providerModel.generalAPI.getCategories();
    await providerModel.generalAPI.getAllDeals();
    await providerModel.prefModel.getLikedProduct();
    setState(() {
      loading = false;
    });
  }

  final List a = [
    {
      'image':
          'https://images-na.ssl-images-amazon.com/images/I/41hjoh3kP9L._UX425_.jpg',
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
          'https://images-na.ssl-images-amazon.com/images/I/41hjoh3kP9L._UX425_.jpg',
      'name': 'Work'
    },
    {
      'image':
          'https://images-na.ssl-images-amazon.com/images/I/41hjoh3kP9L._UX425_.jpg',
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
      getData();
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalData().black,
      body: LoadingOverlay(
        isLoading: loading,
        color: Colors.white,
        opacity: 1,
        progressIndicator: GlobalData().progressIndicatorAsset(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: List.generate(
                  providerModel.generalAPI.allDeals.length,
                  (index) {
                    return InkWell(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        await providerModel.generalAPI.getDealProductById(
                          id: providerModel.generalAPI.allDeals[index].id,
                        );
                        setState(() {
                          loading = false;
                        });
                        GlobalData().navigate(
                          context: context,
                          pageName: ProductListingScreen(
                            heading:
                                providerModel.generalAPI.allDeals[index].name,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: API.getImage +
                              providerModel
                                  .generalAPI.allDeals[index].imageLink,
                          placeholder: (context, url) {
                            return CupertinoActivityIndicator();
                          },
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                ),
                options: CarouselOptions(
                  aspectRatio: 2,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: providerModel.generalAPI.categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        ResponseModel r = await providerModel.generalAPI
                            .getProductByCategory(
                                categoryId: providerModel
                                    .generalAPI.categories[index].id);
                        setState(() {
                          loading = false;
                        });
                        if (r.status) {
                          GlobalData().navigate(
                            context: context,
                            pageName: ProductListingScreen(
                              heading: providerModel
                                  .generalAPI.categories[index].name,
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 60,
                        width: size.width / 2,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              API.getImage +
                                  providerModel.generalAPI.categories[index]
                                      .categoryImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          height: 60,
                          width: size.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: GlobalData().red.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Text(
                              providerModel.generalAPI.categories[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemCount: a.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      GlobalData().navigate(
                          // ignore: missing_required_param
                          context: context, pageName: ProductDetailScreen());
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
                                    child: Image.network(
                                      a[i]['image'],
                                      fit: BoxFit.cover,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0),
                                  child: Text(
                                    'Green & Red Silk With Golden Weaving ja…',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '₹1,931',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        '3,399',
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
                                        '43% off',
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
          ),
        ),
      ),
    );
  }
}
