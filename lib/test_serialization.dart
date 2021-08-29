import 'package:amiibo_guide/model/amiibo_detailed_response.dio.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

void main() async {
  Dio dio = Dio();
  var future = await dio.get("https://www.amiiboapi.com/api/amiibo/?head=00000000&tail=00000002&showusage");

  // var response = DioUtil.instance?.invoke("/amiibo/?id=0x1996&showusage");
  Logger().d("$future");
  var amiibo = Amiibo.from(future.data);
}
