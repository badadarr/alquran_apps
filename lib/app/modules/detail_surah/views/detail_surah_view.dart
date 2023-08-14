import 'package:alquran_apps/app/data/models/detail_surah_model.dart'
as detailModel;
import 'package:alquran_apps/app/data/models/surah_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final SurahModel surah = Get.arguments;

  DetailSurahView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'SURAH ${surah.name?.transliteration?.id?.toUpperCase() ??
                "Error..."}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "${surah.name?.transliteration?.id?.toUpperCase() ??
                        "Error..."}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "( ${surah.name?.translation?.id?.toUpperCase() ??
                        "Error..."} )",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${surah.numberOfVerses ?? "Error..."} Ayat | ${surah
                        .revelation?.id?.toUpperCase() ?? "Error..."}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // membuat list ayat
          FutureBuilder<detailModel.Data>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Data tidak ditemukan'),
                );
              }
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.verses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshot.data?.verses == null ||
                          snapshot.data?.verses?.length == 0) {
                        return Center(
                          child: Text('Data tidak ditemukan'),
                        );
                      }
                      detailModel.Verse? ayat = snapshot.data?.verses?[index];
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                      Card(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                      CircleAvatar(
                      child: Text("${index + 1}"),
                      ),
                      Row(
                      children: [
                      IconButton(
                      onPressed: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                      SnackBar(
                      content: Text(
                      'Ayat ${index + 1} telah ditandai'),
                      duration: Duration(seconds: 1),
                      ),
                      );
                      },
                      icon: Icon(Icons.bookmark_outline)),
                      IconButton(
                      onPressed: null,
                      icon:
                      Icon(Icons.play_arrow_outlined)),
                      ],
                      ),
                      ],
                      ),
                      ),
                      ),
                      SizedBox(height: 20),
                      Text(
                      "${ayat?.text?.arab ?? "Error..."}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 20),
                      Text(
                      "${ayat?.text?.transliteration?.en ?? "Error..."}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      ),
                      ),
                      SizedBox(height: 20),
                      Text(
                      "${ayat?.translation?.id ?? "Error..."}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                      fontSize: 18,
                      ),
                      ),
                      SizedBox(height: 50)
                      ,
                      ]
                      ,
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
