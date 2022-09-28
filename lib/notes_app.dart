import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/screens/home.dart';
import 'package:notes_getx/styles/themes/dark.dart';
import 'package:notes_getx/styles/themes/light.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes Getx",
      theme: light,
      darkTheme: dark,
      home: Home(),
    );
  }
}
