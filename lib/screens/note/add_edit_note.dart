import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/add_edit_note_controller.dart';
import 'package:notes_getx/widgets/delete_bottom_sheet.dart';
import 'package:notes_getx/widgets/note/title_note_text_field.dart';

class AddEditNote extends StatelessWidget {
  AddEditNote({Key? key}) : super(key: key);

  final AddEditNoteController _addEditNoteController =
      Get.put(AddEditNoteController());
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_addEditNoteController.args == null) {
          _addEditNoteController.addNote(
              title: _addEditNoteController.titleTextController.text,
              note: _addEditNoteController.noteTextController.text);
        } else {
          _addEditNoteController.editNote();
        }
        _appController.selectedItems.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Obx(
                () => Visibility(
                  visible: _addEditNoteController.isSaveButtonVisible.value,
                  child: IconButton(
                    onPressed: () {
                      if (_addEditNoteController.args == null) {
                        _addEditNoteController.addNote(
                            title:
                                _addEditNoteController.titleTextController.text,
                            note:
                                _addEditNoteController.noteTextController.text);
                        Get.snackbar(
                          "Note added",
                          "This note has been added to your notes",
                          icon: const Icon(
                            Icons.note_add_rounded,
                            size: 32.0,
                          ),
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(20.0),
                        );
                      } else {
                        _addEditNoteController.editNote();
                        Get.snackbar(
                          "Note edited",
                          "This note has been edited",
                          icon: const Icon(
                            Icons.edit_note_rounded,
                            size: 32.0,
                          ),
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(20.0),
                        );
                      }
                    },
                    icon: const Icon(Icons.done),
                    tooltip: "Save",
                  ),
                ),
              ),
            ),
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              tooltip: "Options",
              onSelected: (value) {
                switch (value) {
                  case "Delete":
                    Get.bottomSheet(
                      DeleteBottomSheet(
                        message: "Delete this note?",
                      ),
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {"Delete"}.map((choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          title: Text(
            _addEditNoteController.args == null
                ? "Insert your note"
                : "Edit note",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TitleNoteTextField(
                hintText: "Title",
                fontSize: 24.0,
                controller: _addEditNoteController.titleTextController,
              ),
              TitleNoteTextField(
                hintText: "Type your note...",
                controller: _addEditNoteController.noteTextController,
                focusNode: _addEditNoteController.noteFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
