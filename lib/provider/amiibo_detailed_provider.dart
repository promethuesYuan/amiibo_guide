import 'package:amiibo_guide/model/amiibo_detailed_response.dio.dart';
import 'package:amiibo_guide/network/dio_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class AmiiboDetailedProvider with ChangeNotifier {
  Amiibo? amiibo;
  late final _head;
  late final _tail;

  AmiiboDetailedProvider(this._head, this._tail) {
    amiibo = null;
    fetchData(_head, _tail);
  }

  fetchData(String head, String tail) async {
    var response = await DioUtil().invoke("/amiibo/?showusage", data: {"head": head, "tail": tail});
    this.amiibo = AmiiboDetailedResponse.from(response).amiibo![0];
    notifyListeners();
  }
}
