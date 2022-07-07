import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);

  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                controller.addNote(
                    title: controller.titleTextController.text,
                    note: controller.noteTextController.text);
              },
              icon: const Icon(Icons.done),
              tooltip: "Save",
            ),
          ),
        ],
        title: const Text("Insert your note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleTextController,
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
                controller: controller.noteTextController,
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
