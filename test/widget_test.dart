import 'dart:convert';

import 'package:alquran_apps/app/data/models/surah_model.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse('https://api.quran.gading.dev/surah');
  var res = await http.get(url);
  List data = (json.decode(res.body) as Map<String, dynamic>)['data'];

  // 1-114 -> index ke 113(surah annas)
  print(data[113]["number"]);

  // data dari api (raw data) -> model (yang sudah diolah)
  SurahModel surahAnnas = SurahModel.fromJson(data[113]);
  print(surahAnnas.toJson());

  Uri urlAnnas = Uri.parse('https://api.quran.gading.dev/surah/${surahAnnas.number}');
  var resAnnas = await http.get(urlAnnas);

    print(resAnnas.body);
}
