import 'package:compareprice/screens/HomeScreen.dart';
import 'package:compareprice/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:compareprice/redux/modal/appModal.dart';
import 'package:compareprice/redux/reducers/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final _initialState = AppState(searchKeyWord: "redmi");
  final Store<AppState> _store = Store<AppState>(
    reducer,
    initialState: _initialState,
    middleware: [thunkMiddleware],
  );
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
      store: store,
    );
  }
}
