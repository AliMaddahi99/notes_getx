import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';

class FolderBottomSheet extends StatelessWidget {
  final String title;
  final Note targetNote;
  final Note draggingNote;
  FolderBottomSheet({
    Key? key,
    required this.title,
    required this.targetNote,
    required this.draggingNote,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size buttonSize =
        Size(MediaQuery.of(context).size.width / 2 - 22, 50);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 200.0,
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
              controller: _folderController.folderTextController,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: buttonSize,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onPressed: () {
                    _folderController.folderTextController.clear();
                    _folderController.isTextFieldEmpty.value = true;
                    Get.back();
                    _appController.isSelectMode.value = false;
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: buttonSize,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
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
                              Get.snackbar(
                                "Folder exists",
                                "This folder is already exist",
                                snackPosition: SnackPosition.BOTTOM,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                margin: const EdgeInsets.all(10.0),
                                padding: const EdgeInsets.all(20.0),
                              );
                            } else {
                              _folderController.createFolder(
                                enteredFolderName,
                                [draggingNote, targetNote],
                              );

                              Get.back();
                              _appController.isSelectMode.value = false;
                            }
                          }
                        : null,
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
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
