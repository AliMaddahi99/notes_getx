import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/folder_screen.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/bottom_sheet_elevated_button.dart';

class OKButton extends StatelessWidget {
  final List<Note>? notes;
  final bool isRename;
  final bool renameFromFolderScreen;
  final bool fromMoveToBottomSheet;
  final String? folderName;

  OKButton({
    super.key,
    required this.notes,
    required this.isRename,
    required this.renameFromFolderScreen,
    required this.fromMoveToBottomSheet,
    required this.folderName,
  });

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomSheetElevatedButton(
        onPressed: !_folderController.isTextFieldEmpty.value
            ? () async {
                var enteredFolderName =
                    _folderController.folderTextController.text;

                Note? existFolderName = await _appController.db.notes
                    .where()
                    .filter()
                    .folderNameEqualTo(enteredFolderName)
                    .and()
                    .isFolderEqualTo(true)
                    .findFirst();

                if (existFolderName != null) {
                  isRename &&
                          existFolderName.folderName == notes!.first.folderName
                      ? {
                          Get.back(),
                          _appController.isSelectMode.value = false,
                          _appController.selectedItems.clear(),
                          _appController.selectedFolderNotes.clear(),
                        }
                      : Get.snackbar(
                          "folder_exists".tr,
                          "folder_exists_message".tr,
                          snackPosition: SnackPosition.BOTTOM,
                          animationDuration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(20.0),
                        );
                } else if (isRename) {
                  await _folderController.renameFolder(
                      enteredFolderName, notes!);
                  // Close FolderBottomSheet
                  Get.back();
                  _appController.isSelectMode.value = false;
                  _appController.selectedItems.clear();
                  _appController.selectedFolderNotes.clear();
                  if (renameFromFolderScreen) {
                    // Go back out of folder
                    Get.back();
                    // Go to selected folder with new name
                    Get.to(
                      () => FolderScreen(folderName: enteredFolderName),
                      transition: Transition.noTransition,
                    );
                  }
                } else {
                  await _folderController.createFolder(
                    enteredFolderName,
                    notes,
                  );

                  Get.back();
                  _appController.isSelectMode.value = false;
                  _folderController.isFolderScreenOpen.value = false;

                  if (fromMoveToBottomSheet) {
                    // Get notes in the folder, if there isn't any note, delete the folder
                    var notesInFolder = await _appController.db.notes
                        .where()
                        .filter()
                        .folderNameEqualTo(folderName)
                        .and()
                        .not()
                        .folderNameIsNull()
                        .findAll();

                    if (notesInFolder.length == 1) {
                      await NoteDatabaseService().deleteNotesFromDb([
                        notesInFolder.first.id,
                      ]);
                      Get.back();
                    }

                    _appController.selectedItems.clear();
                    _appController.selectedFolderNotes.clear();
                    Get.back();
                  }
                }
              }
            : null,
        buttonText: "ok".tr,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
