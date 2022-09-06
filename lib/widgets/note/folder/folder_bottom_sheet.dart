import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/folder_screen.dart';
import 'package:notes_getx/widgets/app/bottom_sheet_elevated_button.dart';

class FolderBottomSheet extends StatelessWidget {
  final String title;
  final List<Note>? notes;
  final bool isRename;

  FolderBottomSheet({
    Key? key,
    required this.title,
    required this.notes,
    this.isRename = false,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  @override
  Widget build(BuildContext context) {
    _folderController.isFolderScreenOpen.value = true;
    if (isRename) {
      _folderController.isTextFieldEmpty.value = false;
    }

    return WillPopScope(
      onWillPop: () async =>
          _folderController.isFolderScreenOpen.value ? false : true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            TextField(
              autofocus: true,
              controller: _folderController.folderTextController
                ..text = isRename ? notes!.first.folderName! : ""
                ..selection = TextSelection(
                    baseOffset: 0,
                    extentOffset:
                        _folderController.folderTextController.text.length),
              decoration: const InputDecoration(
                hintText: "Please enter text...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
              ),
              onChanged: (value) {
                _folderController.isTextFieldEmpty.value = value.isEmpty;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomSheetElevatedButton(
                  onPressed: () {
                    _folderController.folderTextController.clear();
                    _folderController.isTextFieldEmpty.value = true;
                    _folderController.isFolderScreenOpen.value = false;
                    Get.back();
                    _appController.isSelectMode.value = false;
                  },
                  buttonText: "Cancel",
                ),
                Obx(
                  () => BottomSheetElevatedButton(
                    onPressed: !_folderController.isTextFieldEmpty.value
                        ? () async {
                            var enteredFolderName =
                                _folderController.folderTextController.text;

                            Note? existFolderName = await _appController
                                .db.notes
                                .where()
                                .filter()
                                .folderNameEqualTo(enteredFolderName)
                                .and()
                                .isFolderEqualTo(true)
                                .findFirst();

                            if (existFolderName != null) {
                              isRename &&
                                      existFolderName.folderName ==
                                          notes!.first.folderName
                                  ? Get.back()
                                  : Get.snackbar(
                                      "Folder exists",
                                      "This folder is already exist",
                                      snackPosition: SnackPosition.BOTTOM,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.all(10.0),
                                      padding: const EdgeInsets.all(20.0),
                                    );
                            } else if (isRename) {
                              await _folderController.renameFolder(
                                  enteredFolderName, notes!);
                              // Close FolderBottomSheet
                              Get.back();
                              // Go back out of folder
                              Get.back();
                              // Go to selected folder with new name
                              Get.to(
                                () =>
                                    FolderScreen(folderName: enteredFolderName),
                                transition: Transition.noTransition,
                              );
                            } else {
                              await _folderController.createFolder(
                                enteredFolderName,
                                notes,
                              );

                              Get.back();
                              _appController.isSelectMode.value = false;
                              _folderController.isFolderScreenOpen.value =
                                  false;
                            }
                          }
                        : null,
                    buttonText: "OK",
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
