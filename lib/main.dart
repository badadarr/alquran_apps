import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application Al-quran",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    );
  }
}
