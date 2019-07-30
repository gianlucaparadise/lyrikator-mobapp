import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lyrikator/models/MusicxmatchResponse.dart';
import 'package:lyrikator/models/Track.dart';
import 'package:lyrikator/models/TrackList.dart';

class SearchRoute extends StatefulWidget {
  @override
  SearchRouteState createState() => SearchRouteState();
}

class SearchRouteState extends State<SearchRoute> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  List<Track> trackList = [];

  _onSubmitted(String text) async {
    print(text);
    var response = await fetchTrack();
    print(response.message.body.trackList[1].trackName);
    setState(() {
      trackList = response.message.body.trackList;
    });
  }

  Future<MusicxmatchResponse<TrackList>> fetchTrack() async {
    final response = await http.get(
        'http://api.musixmatch.com/ws/1.1/track.search?apikey=4a4b52c64f9891716dd71a70e0ec913c&q_lyrics=excuse+me+while+i+kiss+the+sky');

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
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                onSubmitted: _onSubmitted,
              ),
            ),
            ListView(shrinkWrap: true, children: divided),
          ],
        ));
  }
}
