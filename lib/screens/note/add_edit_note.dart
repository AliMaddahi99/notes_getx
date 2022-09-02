import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/add_edit_note_controller.dart';
import 'package:notes_getx/widgets/note/add_edit_note_app_bar.dart';
import 'package:notes_getx/widgets/note/title_note_text_field.dart';

class AddEditNote extends StatelessWidget {
  final String? folderName;
  AddEditNote({Key? key, this.folderName}) : super(key: key);

  final AppController _appController = Get.find();
  final AddEditNoteController _addEditNoteController =
      Get.put(AddEditNoteController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_addEditNoteController.args == null) {
          await _addEditNoteController.addNote(
            title: _addEditNoteController.titleTextController.text,
            note: _addEditNoteController.noteTextController.text,
            folderName: folderName,
          );
        } else {
          await _addEditNoteController.editNote();
        }
        _appController.selectedItems.clear();
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AddEditNoteAppBar(folderName: folderName),
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
