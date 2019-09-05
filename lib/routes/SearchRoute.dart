import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyrikator/helpers/ConnectionHelper.dart';
import 'package:lyrikator/models/genius/GeniusResponse.dart';

class SearchRoute extends StatefulWidget {
  @override
  SearchRouteState createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> with WidgetsBindingObserver {
  static const platform = const MethodChannel('app.channel.shared.data');

  final _biggerFont = const TextStyle(fontSize: 18.0);
  List<GeniusHitResult> trackList = [];

  final _searchEditController = TextEditingController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // This lifecycle callback is called when your app is closed (not in background)
    _getSavedSearchQuery();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state: $state");
    switch(state) {
      case AppLifecycleState.resumed:
        // This lifecycle callback is called when your app is restored from background
        _getSavedSearchQuery();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.suspending:
        break;
    }
  }

  Future<String> _getSavedSearchQuery() async {
    String searchQuery = await platform.invokeMethod("getSavedSearchQuery");
    if (searchQuery != null) {
      _searchEditController.text = searchQuery;
      _onSearchPress();
      return searchQuery;
    }
    return null;
  }

  _onSearchPress() {
    var query = _searchEditController.text;
    _onSubmitted(query);
  }

  _onSubmitted(String text) async {
    var body = await ConnectionHelper.searchTrackOnGenius(text);

    setState(() {
      trackList = body.response.hits;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = trackList.map(
          (GeniusHitResult hit) {
        return ListTile(
          title: Text(
            hit.result.title,
            style: _biggerFont,
          ),
          subtitle: Text(
            'Author: ${hit.result.primaryArtist.name}',
          ),
          isThreeLine: true,
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Search Lyrics'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextField(
                      onSubmitted: _onSubmitted,
                      controller: _searchEditController,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: _onSearchPress,
                )
              ],
            ),
            Expanded(
              child: ListView(shrinkWrap: true, children: divided),
            )
          ],
        ));
  }
}
