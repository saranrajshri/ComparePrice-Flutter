import 'package:compareprice/components/DataSearch.dart';
import 'package:compareprice/redux/modal/appModal.dart';
import 'package:compareprice/screens/ProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:badges/badges.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _buildItem(int index, AppState state) {
    Map<dynamic, dynamic> data = state.topResults[index];
    if (state.topResults[index] != null) {
      return AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget widget) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 500.0,
              width: Curves.easeInOut.transform(value) * 400.0,
              child: widget,
            ),
          );
        },
        child: GestureDetector(
          onTap: () {
            StoreProvider.of<AppState>(context)
                .dispatch(SelectedProduct(index));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductScreen(),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 35.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        1.0, // Move to right 10  horizontally
                        1.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: "herotag$index",
                        child: Image.network('${data["image"]}',
                            height: 280.0, width: 180.0, fit: BoxFit.fitHeight),
                      ),
                    ),
                    Positioned(
                      top: 30.0,
                      right: 30.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'FROM',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            '${data["price"]}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 30.0,
                      bottom: 30.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${data["productAvailAt"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "${data["productName"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: RawMaterialButton(
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.black,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () =>
                      StoreProvider.of<AppState>(context).dispatch(AddToCart()),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFFFAFAFA),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 60.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 30.0,
                        ),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                      ),
                      state.cart != 0 && state.cart !=null
                          ? Badge(
                              badgeContent: Text(
                                '${state.cart}',
                                style: TextStyle(color: Colors.white),
                              ),
                              child: Icon(
                                Icons.shopping_cart,
                                size: 30.0,
                                color: Colors.black,
                              ),
                            )
                          : Icon(
                              Icons.shopping_cart,
                              size: 30.0,
                              color: Colors.black,
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Top Results',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey.withOpacity(0.6),
                  labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Top',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Amazon',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Flipkart',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'SnapDeal',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Others',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 500.0,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        _selectedPage = index;
                      });
                    },
                    itemCount: state.topResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.topResults.length > 0) {
                        return _buildItem(index, state);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 25.0),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              text: "Product Name : ",
                              children: [
                            TextSpan(
                                text:
                                    "${state.topResults[_selectedPage]["productName"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ])),
                      SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              text: "Price : ",
                              children: [
                            TextSpan(
                                text:
                                    "${state.topResults[_selectedPage]["price"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text:
                                    "${state.topResults[_selectedPage]["productOldPrice"]}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough))
                          ])),
                      SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              text: "Savings : ",
                              children: [
                            TextSpan(
                                text:
                                    "${state.topResults[_selectedPage]["productOldPrice"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ])),
                      SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              text: "Rating : ",
                              children: [
                            TextSpan(
                                text:
                                    "${state.topResults[_selectedPage]["productRating"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ]))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
