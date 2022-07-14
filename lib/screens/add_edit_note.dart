import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/add_edit_note_controller.dart';
import 'package:notes_getx/widgets/delete_bottom_sheet.dart';

class AddEditNote extends StatelessWidget {
  AddEditNote({Key? key}) : super(key: key);

  final AddEditNoteController _editNoteController =
      Get.put(AddEditNoteController());

  void toggleSaveButtonVisibility() {
    _editNoteController.saveButtonVisibility()
        ? _editNoteController.isSaveButtonVisible.value = true
        : _editNoteController.isSaveButtonVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_editNoteController.args == null) {
          _editNoteController.addNote(
              title: _editNoteController.titleTextController.text,
              note: _editNoteController.noteTextController.text);
        } else {
          _editNoteController.editNote();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Obx(
                () => Visibility(
                  visible: _editNoteController.isSaveButtonVisible.value,
                  child: IconButton(
                    onPressed: () {
                      if (_editNoteController.args == null) {
                        _editNoteController.addNote(
                            title: _editNoteController.titleTextController.text,
                            note: _editNoteController.noteTextController.text);
                      } else {
                        _editNoteController.editNote();
                      }
                    },
                    icon: const Icon(Icons.done),
                    tooltip: "Save",
                  ),
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case "Delete":
                    Get.bottomSheet(
                      DeleteBottomSheet(),
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
            _editNoteController.args == null ? "Insert your note" : "Edit note",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                minLines: 1,
                maxLines: 4000000000,
                controller: _editNoteController.titleTextController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 24.0),
                onChanged: (text) {
                  toggleSaveButtonVisibility();
                },
              ),
              TextField(
                minLines: 1,
                maxLines: 4000000000,
                controller: _editNoteController.noteTextController,
                focusNode: _editNoteController.noteFocusNode,
                decoration: const InputDecoration(
                  hintText: "Type your note...",
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  toggleSaveButtonVisibility();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
