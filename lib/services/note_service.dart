import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';

class NoteService {
  NoteService();
  final AppController _appController = Get.find();

  Future<Note?> getNoteFromDb(int id) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.notes.get(id));
  }

  Future<List<Note?>> getNotesFromDb(List<int> ids) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.notes.getAll(ids));
  }

  Future<int> addNoteToDb(Note note) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.notes.put(note));
  }

  Future<void> updateNoteInDb(Note note) async {
    await _appController.db
        .writeTxn((isar) async => await isar.notes.put(note));
  }

  Future<void> deleteNotesFromDb(List<int> ids) async {
    await _appController.db
        .writeTxn((isar) async => await isar.notes.deleteAll(ids));
  }
}
