import 'package:compareprice/redux/modal/appModal.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is SearchKeyWord) {
    newState.searchKeyWord = action.payload;
  }

  if (action is AmazonResults) {
    newState.amazonResults = action.payload;
    print(newState.amazonResults);
  }

  if (action is FlipKartResults) {
    newState.flipKartResults = action.payload;
  }
  if (action is TopResults) {
    newState.topResults = action.payload;
  }
  if (action is SelectedProduct) {
    newState.selectedProduct = action.payload;
  }
  if (action is AddToCart) {
    if (newState.cart == null) {
      newState.cart = 1;
    } else {
      newState.cart += 1;
    }
    print(newState.cart);
  }

  if (action is GetResults) {
    getData() async {
      print("Fetching Data.....");
      String url =
          "https://compareprice-flask.herokuapp.com/api/getPriceDetails?searchKeyWord=${newState.searchKeyWord}";
      Response response = await get(url);
      String json = response.body;
      Map<String, dynamic> results = jsonDecode(json);
      List<dynamic> topResults;
      // print(results["amazonResults"]);
      topResults = results["topResults"];
      newState.topResults = topResults;
      print("Got Results !!");
    }

    getData();
  }

  return newState;
}
