import 'package:compareprice/redux/modal/appModal.dart';
import 'package:compareprice/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
    // send data to redux
    StoreProvider.of<AppState>(context).dispatch(SearchKeyWord(query));
    StoreProvider.of<AppState>(context).dispatch(GetResults());

    Future.delayed(const Duration(seconds: 8), () {
      close(context, null);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    return Text(" ");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSearches
        : prodcutNames.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
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
