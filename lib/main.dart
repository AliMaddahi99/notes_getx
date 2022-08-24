import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/folder.dart';
import 'package:notes_getx/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'notes_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppController appController = Get.put(AppController());

  await GetStorage.init();

  appController.db = await Isar.open(
    schemas: [
      NoteSchema,
      FolderSchema,
    ],
    directory: (await getApplicationDocumentsDirectory()).path,
  );
  // await appController.db.writeTxn((isar) async => await isar.notes.clear());
  // await appController.db.writeTxn((isar) async => await isar.folders.clear());

  runApp(const NotesApp());
}
