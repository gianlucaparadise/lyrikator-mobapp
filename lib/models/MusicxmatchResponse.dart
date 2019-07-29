class MusicxmatchResponse<T> {
  MusicxmatchResponseMainBody<T> message;

  MusicxmatchResponse({this.message});

  factory MusicxmatchResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) bodyParser) {
    return MusicxmatchResponse(
      message: MusicxmatchResponseMainBody.fromJson(json['message'], bodyParser)
    );
  }
}

class MusicxmatchResponseMainBody<T> {
  MusicxmatchResponseHeader header;
  T body;

  MusicxmatchResponseMainBody({this.header, this.body});

  factory MusicxmatchResponseMainBody.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) bodyParser) {
    return MusicxmatchResponseMainBody(
      header: MusicxmatchResponseHeader.fromJson(json['header']),
      body: bodyParser(json['body']),
    );
  }
}

class MusicxmatchResponseHeader {
  int statusCode;
  int available;

  MusicxmatchResponseHeader({this.statusCode, this.available});

  factory MusicxmatchResponseHeader.fromJson(Map<String, dynamic> json) {
    return MusicxmatchResponseHeader(
      statusCode: json['status_code'],
      available: json['available'],
    );
  }
}
