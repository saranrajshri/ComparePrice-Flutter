import 'package:compareprice/redux/modal/appModal.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is SearchKeyWord) {
    newState.searchKeyWord = action.payload;
    print("key=>${newState.searchKeyWord}");
  }

  if (action is AmazonResults) {
    newState.amazonResults = action.payload;
    print(newState.amazonResults);
  }

  if (action is FlipKartResults) {
    newState.flipKartResults = action.payload;
  }

  if (action is GetResults) {
    getData() async {
      String url =
          "https://compareprice-flask.herokuapp.com/api/getPriceDetails?searchKeyWord=${newState.searchKeyWord}";
      Response response = await get(url);
      String json = response.body;
      Map<String, dynamic> results = jsonDecode(json);
      List<dynamic> amazonResults;
      // print(results["amazonResults"]);
      amazonResults = results["amazonResults"];
      newState.amazonResults = amazonResults;
      print(newState.amazonResults);
    }

    getData();
  }

  return newState;
}
