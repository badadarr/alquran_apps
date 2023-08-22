import 'dart:convert';

import 'package:alquran_apps/app/data/models/detail_surah_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class DetailSurahController extends GetxController {
  //TODO: Implement DetailSurahController
  Future<DetailSurahModel> getDetailSurah(String id) async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah/$id');
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];

    return DetailSurahModel.fromJson(data);
  }
}
