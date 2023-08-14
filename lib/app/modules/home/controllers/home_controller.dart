import 'dart:convert';

import 'package:alquran_apps/app/data/models/surah_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  Future<List<SurahModel>> getAllSurah() async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah');
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)['data'];

    if(data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => SurahModel.fromJson(e)).toList();
    }
  }
}
