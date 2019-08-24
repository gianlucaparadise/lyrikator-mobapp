class GeniusResponse {
  GeniusMeta meta;
  GeniusResponseBody response;

  GeniusResponse({this.meta, this.response});

  factory GeniusResponse.fromJson(Map<String, dynamic> json) {
    return GeniusResponse(
        meta: GeniusMeta.fromJson(json['meta']),
        response: GeniusResponseBody.fromJson(json['response']));
  }
}

class GeniusMeta {
  int status;

  GeniusMeta({this.status});

  factory GeniusMeta.fromJson(Map<String, dynamic> json) {
    return GeniusMeta(status: json['status']);
  }
}

class GeniusResponseBody {
  List<GeniusHitResult> hits;

  GeniusResponseBody({this.hits});

  factory GeniusResponseBody.fromJson(Map<String, dynamic> json) {
    var hitResultListRaw = json['hits'] as List;
    var hitResultList =
        hitResultListRaw.map((i) => GeniusHitResult.fromJson(i)).toList();

    return GeniusResponseBody(hits: hitResultList);
  }
}

class GeniusHitResult {
  GeniusSearchResult result;

  GeniusHitResult({this.result});

  factory GeniusHitResult.fromJson(Map<String, dynamic> json) {
    return GeniusHitResult(result: GeniusSearchResult.fromJson(json['result']));
  }
}

class GeniusSearchResult {
  int id;
  String title;
  GeniusArtist primary_artist;

  GeniusSearchResult(
      {this.id, this.title, this.primary_artist});

  factory GeniusSearchResult.fromJson(Map<String, dynamic> json) {
    return GeniusSearchResult(
      id: json['id'],
      title: json['title'],
      primary_artist: GeniusArtist.fromJson(json['primary_artist']),
    );
  }
}

class GeniusArtist {
  int id;
  String name;

  GeniusArtist({this.id, this.name});

  factory GeniusArtist.fromJson(Map<String, dynamic> json) {
    return GeniusArtist(
      id: json['id'],
      name: json['name'],
    );
  }
}
