import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/folder.dart';

class FolderDatabaseService {
  FolderDatabaseService();
  final AppController _appController = Get.find();

  Future<Folder?> getFolderFromDb(int id) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.folders.get(id));
  }

  Future<List<Folder?>> getFoldersFromDb(List<int> ids) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.folders.getAll(ids));
  }

  Future<int> addFolderToDb(Folder folder) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.folders.put(folder));
  }

  Future<int> updateFolderInDb(Folder folder) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.folders.put(folder));
  }

  Future<int> deleteFoldersFromDb(List<int> ids) async {
    return await _appController.db
        .writeTxn((isar) async => await isar.folders.deleteAll(ids));
  }
}
