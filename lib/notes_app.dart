import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/screens/home.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Notes Getx",
      home: Home(),
    );
  }
}
