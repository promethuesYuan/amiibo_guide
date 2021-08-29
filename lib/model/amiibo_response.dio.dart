import 'dart:convert';
import 'amiibo_detailed_response.dio.dart';

class AmiiboResponse {
  List<Amiibo>? amiibo = [];

  AmiiboResponse({this.amiibo});

  AmiiboResponse.from(json) {
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
        "head": head,
        "image": image,
        "name": name,
        "release": release,
        "tail": tail,
        "type": type
      }}';
}
