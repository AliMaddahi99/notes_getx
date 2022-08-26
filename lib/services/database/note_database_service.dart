import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';

class NoteDatabaseService {
  NoteDatabaseService();
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

  Future<int> updateNoteInDb(Note note) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.notes.put(note));
  }

  Future<List<int>> updateNotesInDb(List<Note> notes) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.notes.putAll(notes));
  }

  Future<int> deleteNotesFromDb(List<int> ids) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.notes.deleteAll(ids));
  }
}
