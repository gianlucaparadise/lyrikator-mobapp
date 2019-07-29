class Track {
  int trackId;
  int commonTrackId;
  String trackName;
  String artistName;
  int trackRating;
  int numFavourite;

  Track({this.trackId, this.commonTrackId, this.trackName, this.artistName, this.trackRating, this.numFavourite});

  factory Track.fromJson(Map<String, dynamic> json) {
    var jsonTrack = json['track'];

    return Track(
      trackId: jsonTrack['track_id'],
      commonTrackId: jsonTrack['commontrack_id'],
      trackName: jsonTrack['track_name'],
      artistName: jsonTrack['artist_name'],
      trackRating: jsonTrack['track_rating'],
      numFavourite: jsonTrack['num_favourite'],
    );
  }
}