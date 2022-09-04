import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/bottom_sheet_elevated_button.dart';

class DeleteBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final bool deleteFromAddEditNoteScreen;
  final bool deleteFromFolderScreen;
  final String? folderName;
  DeleteBottomSheet({
    Key? key,
    required this.title,
    required this.message,
    this.deleteFromAddEditNoteScreen = false,
    this.deleteFromFolderScreen = false,
    this.folderName,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomSheetElevatedButton(
                onPressed: () => Get.back(),
                buttonText: "Cancel",
              ),
              BottomSheetElevatedButton(
                onPressed: _appController.pageViewId.value == 0
                    ? () async {
                        if (deleteFromAddEditNoteScreen) {
                          var deletingNote = await NoteDatabaseService()
                              .getNoteFromDb(
                                  _appController.selectedItems.first);

                          var notesInFolder = await _appController.db.notes
                              .where()
                              .filter()
                              .folderNameEqualTo(deletingNote!.folderName)
                              .findAll();

                          if (deletingNote.folderName != null &&
                              notesInFolder.length <= 2) {
                            NoteDatabaseService().deleteNotesFromDb([
                              notesInFolder[0].id,
                              notesInFolder[1].id,
                            ]);

                            // back to FolderScreen()
                            Get.back();
                          }

                          // while delete from add_edit_note
                          // it need to Get.back() twice,
                          // one for closing bottomSheet
                          // and antother for go back to list of notes
                          // this one will close bottomsheet in add_edit_note
                          Get.back();
                        }

                        if (deleteFromFolderScreen) {
                          var notesInFolder = await _appController.db.notes
                              .where()
                              .filter()
                              .folderNameEqualTo(folderName)
                              .findAll();

                          var ids = notesInFolder.map((n) => n.id).toList();

                          // using +1, means that by selecting all notes of folder,
                          // the folder itself is selected too,
                          // (actually it's selected above, in notesInFolder)
                          // [ notesInFolder.length < selectedItem.length
                          // notesInFolder.length +1 == selectedItem.length ]
                          // and
                          // using >=, is because the folder is selected in
                          // folder_screen_main_app_bar -> PopupMenuButton -> Delete
                          // so selectedItems already has the folder in itself
                          // [ notesInFolder.length == selectedItem.length
                          // notesInFolder.length +1 > selectedItem.length ]
                          if (_appController.selectedItems.length + 1 >=
                              notesInFolder.length) {
                            NoteDatabaseService().deleteNotesFromDb(ids);

                            // back to NoteHome()
                            Get.back();
                          }
                        }

                        await NoteDatabaseService().deleteNotesFromDb([
                          ..._appController.selectedItems.toList(),
                          ..._appController.selectedFolderNotes.toList(),
                        ]);

                        _appController.selectedItems.clear();
                        _appController.selectedFolderNotes.clear();
                        _appController.isSelectMode.value = false;
                        Get.back();
                      }
                    : () {
                        for (var t in _appController.selectedItems) {
                          _taskController.deleteTask(t);
                        }

                        _appController.selectedItems.clear();
                        _appController.isSelectMode.value = false;
                        Get.back();
                      },
                buttonText: "Delete",
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
