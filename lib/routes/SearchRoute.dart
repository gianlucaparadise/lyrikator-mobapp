import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lyrikator/helpers/Secrets.dart';
import 'package:lyrikator/models/MusicxmatchResponse.dart';
import 'package:lyrikator/models/Track.dart';
import 'package:lyrikator/models/TrackList.dart';

class SearchRoute extends StatefulWidget {
  @override
  SearchRouteState createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  static const platform = const MethodChannel('app.channel.shared.data');

  final _biggerFont = const TextStyle(fontSize: 18.0);
  List<Track> trackList = [];

  final _searchEditController = TextEditingController();

  @override
  initState() {
    super.initState();
    _getSavedSearchQuery();
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
    var response = await fetchTrack(text);

    var sortedTrackList = response.message.body.trackList;
    sortedTrackList
        .sort((t1, t2) => t2.numFavourite.compareTo(t1.numFavourite));

    setState(() {
      trackList = sortedTrackList;
    });
  }

  Future<MusicxmatchResponse<TrackList>> fetchTrack(String text) async {
    // TODO: Improve this code to avoid several loading of the same file
    SecretsLoader secretLoader = SecretsLoader();
    Secrets secrets = await secretLoader.load();

    var queryParameters = {
      'apikey': secrets.musicxmatchApiKey,
      'q_lyrics': text,
      's_track_rating': 'desc',
      'page_size': '100', // 100 is the max size of a page
    };

    var uri =
    Uri.http('api.musixmatch.com', '/ws/1.1/track.search', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return MusicxmatchResponse.fromJson(
          json.decode(response.body), (json) => TrackList.fromJson(json));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load track');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = trackList.map(
          (Track track) {
        return ListTile(
          title: Text(
            track.trackName,
            style: _biggerFont,
          ),
          subtitle: Text(
            'Author: ${track.artistName}\nFavorite: ${track
                .numFavourite} Track Rating: ${track.trackRating}',
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
