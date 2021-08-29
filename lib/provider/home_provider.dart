import 'package:amiibo_guide/model/amiibo_response.dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class HomeProvider with ChangeNotifier {
  List<Amiibo>? get list => _list;
  List<Amiibo>? _list;

  HomeProvider() {
    loadData();
  }

  loadData() async {
    var jsonData = await rootBundle.loadString("assets/json/amiibo_response.json");
    this._list = AmiiboResponse.from(jsonData).amiibo!;
    notifyListeners();
    Logger().d("load finish");
  }
}
