import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/add_edit_note_controller.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/widgets/delete_bottom_sheet.dart';

class AddEditNote extends StatelessWidget {
  AddEditNote({Key? key}) : super(key: key);

  final AddEditNoteController _addEditNoteController =
      Get.put(AddEditNoteController());
  final NoteController _controller = Get.find();

  void toggleSaveButtonVisibility() {
    _addEditNoteController.saveButtonVisibility()
        ? _addEditNoteController.isSaveButtonVisible.value = true
        : _addEditNoteController.isSaveButtonVisible.value = false;
  }

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
        _controller.selectedNote.clear();
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
                      } else {
                        _addEditNoteController.editNote();
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
              TextField(
                minLines: 1,
                maxLines: 4000000000,
                controller: _addEditNoteController.titleTextController,
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
                controller: _addEditNoteController.noteTextController,
                focusNode: _addEditNoteController.noteFocusNode,
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
