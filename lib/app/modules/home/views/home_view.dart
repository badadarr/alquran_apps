import 'package:alquran_apps/app/data/models/surah_model.dart';
import 'package:alquran_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al-quran Apps'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SurahModel>>(
          future: controller.getAllSurah(),
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
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  SurahModel surah = snapshot.data![index];
                  return ListTile(
                    onTap: () => Get.toNamed(Routes.DETAIL_SURAH, arguments: surah),
                    leading: CircleAvatar(
                      child: Text(surah.number.toString()),
                    ),
                    title: Text(
                      'Surah Al - ${surah.name?.transliteration?.id ?? "Error..."}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? "Error..."}'),
                    trailing: Text("${surah.name?.short ?? "Error..."}"),
                  );
                });
          }),
    );
  }
}
