import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_getx/services/database/database.dart';
import 'notes_app.dart';

void main() async {
  await GetStorage.init();
  await Database().initIsar();
  // await appController.db.writeTxn((isar) async => await isar.notes.clear());
  // await appController.db.writeTxn((isar) async => await isar.folders.clear());

  runApp(const NotesApp());
}
