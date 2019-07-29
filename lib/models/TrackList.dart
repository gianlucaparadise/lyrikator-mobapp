import 'package:lyrikator/models/Track.dart';

class TrackList {
  List<Track> trackList;

  TrackList({this.trackList});

  factory TrackList.fromJson(Map<String, dynamic> json) {
    var trackListRaw = json['track_list'] as List;
    var trackList = trackListRaw.map((i) => Track.fromJson(i)).toList();

    return TrackList(
      trackList: trackList
    );
  }
}