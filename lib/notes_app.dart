import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/screens/home.dart';
import 'package:notes_getx/services/translations/translates.dart';
import 'package:notes_getx/styles/themes/dark.dart';
import 'package:notes_getx/styles/themes/light.dart';

class NotesApp extends StatelessWidget {
  NotesApp({Key? key}) : super(key: key);

  // AppController is Get.find() because it's Get.put() in database.dart
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes Getx",
      theme: light,
      darkTheme: dark,
      translations: Translates(),
      locale: _appController.isLanguagePersian.value
          ? const Locale('fa', 'IR')
          : const Locale('en', 'US'),
      home: Home(),
    );
  }
}
