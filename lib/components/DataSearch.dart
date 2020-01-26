import 'package:compareprice/redux/modal/appModal.dart';
import 'package:compareprice/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';

class DataSearch extends SearchDelegate<String> {
  final prodcutNames = [
    'redmi',
    'honor',
    'redmi note 7',
    'iphone',
    'honor 8x',
    'samsung j6',
    'earphones',
    'brush'
  ];

  final recentSearches = ['mixer', 'hair dryer', 'phone case'];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    void navigationScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    startTime() async {
      var _duration = Duration(seconds: 10);
      return Timer(_duration, navigationScreen);
    }

    getData() async {
      print("Fetching Data....");

      String url =
          "https://compareprice-flask.herokuapp.com/api/getPriceDetails?searchKeyWord=${query}";
      Response response = await get(url);
      String json = response.body;
      Map<String, dynamic> results = jsonDecode(json);
      List<dynamic> topResults;
      // print(results["amazonResults"]);
      topResults = results["topResults"];

      StoreProvider.of<AppState>(context).dispatch(TopResults(topResults));
      close(context, null);
    }

    void _getResults() {
      getData();
    }

    // send data to redux
    StoreProvider.of<AppState>(context).dispatch(SearchKeyWord(query));
    StoreProvider.of<AppState>(context).dispatch(TopResults([]));
    AlertDialog(
      title: Text("loading"),
    );

    _getResults();
    // startTime();

    return Text(" ");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    void _showLoader() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  height: 40.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
            );
          });
    }

    final suggestionList = query.isEmpty
        ? recentSearches
        : prodcutNames.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          _showLoader();
          query = suggestionList[index];
          showResults(context);
        },
        leading: Icon(Icons.mobile_screen_share),
        // title: RichText(
        //   text: TextSpan(
        //       text: suggestionList[index].substring(0, query.length),
        //       style:
        //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //       children: [
        //         TextSpan(
        //             text: suggestionList[index].substring(0, query.length),
        //             style: TextStyle(color: Colors.grey))
        //       ]),
        // ),
        title: Text(
          suggestionList[index],
          style: TextStyle(color: Colors.black),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
