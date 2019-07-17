import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Secrets {
  final String musicxmatchApiKey;
  Secrets({this.musicxmatchApiKey = ""});
  factory Secrets.fromJson(Map<String, dynamic> jsonMap) {
    return new Secrets(musicxmatchApiKey: jsonMap["musicxmatch-api-key"]);
  }
}

class SecretsLoader {
  final String secretPath;

  SecretsLoader({this.secretPath = 'assets/config/secrets.json'});
  Future<Secrets> load() {
    return rootBundle.loadStructuredData<Secrets>(this.secretPath,
        (jsonStr) async {
      final secret = Secrets.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
