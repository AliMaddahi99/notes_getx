import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  final AppController _appController = Get.put(AppController());

  Future<Isar> initIsar() async {
    WidgetsFlutterBinding.ensureInitialized();

    return _appController.db = await Isar.open(
      [
        NoteSchema,
      ],
      directory: (await getApplicationDocumentsDirectory()).path,
    );
  }
}
