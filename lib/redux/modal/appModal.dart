import 'package:flutter/material.dart';

class AppState {
  String searchKeyWord;
  List<dynamic> amazonResults;
  List<dynamic> flipKartResults;
  List<dynamic> topResults;
  AppState({
    @required this.searchKeyWord,
  });

  AppState.fromAppState(AppState another) {
    searchKeyWord = another.searchKeyWord;
    amazonResults = another.amazonResults;
    flipKartResults = another.flipKartResults;
    topResults = another.topResults;
  }

  String get getSearchKeyWord => searchKeyWord;
  List<dynamic> get getAmazonResults => amazonResults;
  List<dynamic> get getFlipKartResults => flipKartResults;
  List<dynamic> get getTopResults => topResults;
}

class SearchKeyWord {
  final String payload;
  SearchKeyWord(this.payload);
}

class AmazonResults {
  final List<dynamic> payload;
  AmazonResults(this.payload);
}

class FlipKartResults {
  final List<dynamic> payload;
  FlipKartResults(this.payload);
}

class GetResults {
  GetResults();
}

class TopResults {
  final List<dynamic> payload;
  TopResults(this.payload);
}
