import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/edit_note_controller.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class EditNote extends StatelessWidget {
  EditNote({Key? key}) : super(key: key);

  final NoteController controller = Get.find();
  final EditNoteController editNoteController = Get.put(EditNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                var edited = controller.notes[editNoteController.args];
                edited.title = editNoteController.titleTextController.text;
                edited.note = editNoteController.noteTextController.text;
                edited.dateTime = DateTime.now().toString();
                controller.notes[editNoteController.args] = edited;
              },
              icon: const Icon(Icons.done),
              tooltip: "Save",
            ),
          ),
        ],
        title: const Text("Edit note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: editNoteController.titleTextController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24.0),
            ),
            Expanded(
              child: TextField(
                expands: true,
                minLines: null,
                maxLines: null,
                controller: editNoteController.noteTextController,
                focusNode: controller.noteFocusNode,
                decoration: const InputDecoration(
                  hintText: "Type your note...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
