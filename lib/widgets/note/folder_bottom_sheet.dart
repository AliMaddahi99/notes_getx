import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note_model.dart';

class FolderBottomSheet extends StatelessWidget {
  final String title;
  final int targetNoteId;
  final int draggingNoteId;
  FolderBottomSheet({
    Key? key,
    required this.title,
    required this.targetNoteId,
    required this.draggingNoteId,
  }) : super(key: key);

  final FolderController _folderController = Get.find();
  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
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
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 2 - 22, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onPressed: () {
                    _folderController.folderTextController.clear();
                    _folderController.isTextFieldEmpty.value = true;
                    Get.back();
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
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2 - 22, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: !_folderController.isTextFieldEmpty.value
                        ? () {
                            var enteredFolderName =
                                _folderController.folderTextController.text;

                            var foldersName = _folderController.folders
                                .map((folder) => folder.name);
                            if (foldersName.contains(enteredFolderName)) {
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
                              List<NoteModel> notes = [
                                _noteController.notes.firstWhere(
                                    (note) => note.id == draggingNoteId),
                                _noteController.notes.firstWhere(
                                    (note) => note.id == targetNoteId),
                              ];

                              _folderController.createFolder(
                                  enteredFolderName, notes);

                              Get.back();
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
