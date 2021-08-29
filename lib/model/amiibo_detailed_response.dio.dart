import 'dart:convert';

class AmiiboDetailedResponse {
  List<Amiibo>? amiibo = [];

  AmiiboDetailedResponse({this.amiibo});

  AmiiboDetailedResponse.from(json) {
    if (json is String) json = jsonDecode(json);
    if (json['amiibo'] != null) amiibo = (json['amiibo'] as Iterable).map((it) => Amiibo.from(it)).toList();
  }

  @override
  String toString() => '${{"amiibo": amiibo}}';
}

class Amiibo {
  String? amiiboSeries = '';
  String? character = '';
  String? gameSeries = '';
  List<Games3DS>? games3DS = [];
  List<Games3DS>? gamesSwitch = [];
  List<Games3DS>? gamesWiiU = [];
  String? head = '';
  String? image = '';
  String? name = '';
  Release? release;
  String? tail = '';
  String? type = '';

  Amiibo(
      {this.amiiboSeries,
      this.character,
      this.gameSeries,
      this.games3DS,
      this.gamesSwitch,
      this.gamesWiiU,
      this.head,
      this.image,
      this.name,
      this.release,
      this.tail,
      this.type});

  Amiibo.from(json) {
    if (json is String) json = jsonDecode(json);
    if (json['amiiboSeries'] != null) amiiboSeries = json['amiiboSeries'];
    if (json['character'] != null) character = json['character'];
    if (json['gameSeries'] != null) gameSeries = json['gameSeries'];
    if (json['games3DS'] != null) games3DS = (json['games3DS'] as Iterable).map((it) => Games3DS.from(it)).toList();
    if (json['gamesSwitch'] != null)
      gamesSwitch = (json['gamesSwitch'] as Iterable).map((it) => Games3DS.from(it)).toList();
    if (json['gamesWiiU'] != null) gamesWiiU = (json['gamesWiiU'] as Iterable).map((it) => Games3DS.from(it)).toList();
    if (json['head'] != null) head = json['head'];
    if (json['image'] != null) image = json['image'];
    if (json['name'] != null) name = json['name'];
    if (json['release'] != null) release = Release.from(json['release']);
    if (json['tail'] != null) tail = json['tail'];
    if (json['type'] != null) type = json['type'];
  }

  @override
  String toString() => '${{
        "amiiboSeries": amiiboSeries,
        "character": character,
        "gameSeries": gameSeries,
        "games3DS": games3DS,
        "gamesSwitch": gamesSwitch,
        "gamesWiiU": gamesWiiU,
        "head": head,
        "image": image,
        "name": name,
        "release": release,
        "tail": tail,
        "type": type
      }}';
}

class Release {
  String? au = '';
  String? eu = '';
  String? jp = '';
  String? na = '';

  Release({this.au, this.eu, this.jp, this.na});

  Release.from(json) {
    if (json is String) json = jsonDecode(json);
    if (json['au'] != null) au = json['au'];
    if (json['eu'] != null) eu = json['eu'];
    if (json['jp'] != null) jp = json['jp'];
    if (json['na'] != null) na = json['na'];
  }

  @override
  String toString() => '${{"au": au, "eu": eu, "jp": jp, "na": na}}';
}

class Games3DS {
  List<AmiiboUsage>? amiiboUsage = [];
  List<String>? gameID = [];
  String? gameName = '';

  Games3DS({this.amiiboUsage, this.gameID, this.gameName});

  Games3DS.from(json) {
    if (json is String) json = jsonDecode(json);
    if (json['amiiboUsage'] != null)
      amiiboUsage = (json['amiiboUsage'] as Iterable).map((it) => AmiiboUsage.from(it)).toList();
    if (json['gameID'] != null) gameID = (json['gameID'] as Iterable).map((it) => it as String).toList();
    if (json['gameName'] != null) gameName = json['gameName'];
  }

  @override
  String toString() => '${{"amiiboUsage": amiiboUsage, "gameID": gameID, "gameName": gameName}}';
}

class AmiiboUsage {
  String? Usage = '';
  bool? write = false;

  AmiiboUsage({this.Usage, this.write});

  AmiiboUsage.from(json) {
    if (json is String) json = jsonDecode(json);
    if (json['Usage'] != null) Usage = json['Usage'];
    if (json['write'] != null) write = json['write'];
  }

  @override
  String toString() => '${{"Usage": Usage, "write": write}}';
}
