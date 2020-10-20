import 'package:dio/dio.dart';
import 'dart:convert' as convert;

import 'package:flutter_fiap_aula_http_mapas/model/listPositions.dart';

Future<ListPositions> getPositions() async {
  Dio dio = Dio();

  //código pra aula - mas confesso, está feio
  ListPositions positions;
  try {
    Response response = await dio
        .get('https://run.mocky.io/v3/f9e92242-c207-47bb-a7be-ae01fa5ff4ba');

    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse["success"]) {
        positions = ListPositions.fromJson(jsonResponse);
      }
    }
  } finally {
    dio.close();
  }

  return positions;
}
