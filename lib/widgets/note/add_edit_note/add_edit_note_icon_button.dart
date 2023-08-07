import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/add_edit_note_controller.dart';

class AddEditNoteIconButton extends StatelessWidget {
  final String? folderName;
  AddEditNoteIconButton({super.key, this.folderName});

  final AddEditNoteController _addEditNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Obx(
        () => Visibility(
          visible: _addEditNoteController.isSaveButtonVisible.value,
          child: IconButton(
            onPressed: () async {
              if (_addEditNoteController.args == null) {
                await _addEditNoteController.addNote(
                  title: _addEditNoteController.titleTextController.text,
                  note: _addEditNoteController.noteTextController.text,
                  folderName: folderName,
                );
                Get.snackbar(
                  "note_added".tr,
                  "note_added_message".tr,
                  icon: const Icon(
                    Icons.note_add_rounded,
                    size: 32.0,
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  animationDuration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(20.0),
                );
              } else {
                await _addEditNoteController.editNote();
                Get.snackbar(
                  "note_edited".tr,
                  "note_edited_message".tr,
                  icon: const Icon(
                    Icons.edit_note_rounded,
                    size: 32.0,
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  animationDuration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(20.0),
                );
              }
            },
            icon: const Icon(Icons.done),
            tooltip: "save".tr,
          ),
        ),
      ),
    );
  }
}
