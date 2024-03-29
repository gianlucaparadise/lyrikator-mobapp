import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lyrikator/helpers/Secrets.dart';
import 'package:lyrikator/models/MusicxmatchResponse.dart';
import 'package:lyrikator/models/TrackList.dart';
import 'package:lyrikator/models/genius/GeniusResponse.dart';

class ConnectionHelper {
  static Future<MusicxmatchResponse<TrackList>> searchTrackOnMusicxmatch(
      String text) async {
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

  static Future<GeniusResponse> searchTrackOnGenius(String text) async {
    // TODO: Improve this code to avoid several loading of the same file
    SecretsLoader secretLoader = SecretsLoader();
    Secrets secrets = await secretLoader.load();

    var queryParameters = {'q': text};

    var headers = {
      'Authorization': 'Bearer ${secrets.geniusAccessToken}',
    };

    var uri = Uri.https('api.genius.com', '/search', queryParameters);
    final response = await http.get(uri, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return GeniusResponse.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load track');
    }
  }
}
