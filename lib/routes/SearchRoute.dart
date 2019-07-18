import 'package:flutter/material.dart';

class SearchRoute extends StatefulWidget {
  @override
  SearchRouteState createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  _onSubmitted(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child:  TextField(
          onSubmitted: _onSubmitted,
        ),
      )
    );
  }
}