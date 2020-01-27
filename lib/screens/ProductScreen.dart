import 'package:compareprice/redux/modal/appModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                          top: 60.0,
                        ),
                        height: 520.0,
                        color: Color(0xFF32A060),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
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
                            SizedBox(height: 20.0),
                            Text(
                              "FROM AMAZON",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "${state.topResults[state.selectedProduct]["productName"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Text(
                              'PRICE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "${state.topResults[state.selectedProduct]["price"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Text(
                              'RATING',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "${state.topResults[state.selectedProduct]["productRating"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 40.0),
                            RawMaterialButton(
                              padding: EdgeInsets.all(20.0),
                              shape: CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.black,
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              onPressed: () => print('Add to cart'),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   right: 0.0,
                      //   bottom: 30.0,
                      //   child: Hero(
                      //       tag: "widget.plant.imageUrl",
                      //       child: Image.network(
                      //         "${state.topResults[state.selectedProduct]["image"]}",
                      //         height: 280.0,
                      //         width: 180.0,
                      //         fit: BoxFit.cover,
                      //       )),
                      // ),
                    ],
                  ),
                  Container(
                    height: 400.0,
                    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 40.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'All to know...',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                " widget.plant.description,,",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 40.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Plant height: 35-45cm',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Nursery pot width: 12cm',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
