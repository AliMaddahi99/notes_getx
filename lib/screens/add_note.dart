import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);

  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                _controller.addNote(
                    title: _controller.titleTextController.text,
                    note: _controller.noteTextController.text);
              },
              icon: const Icon(Icons.done),
              tooltip: "Save",
            ),
          ),
        ],
        title: const Text("Insert your note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              minLines: 1,
              maxLines: 4000000000,
              controller: _controller.titleTextController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24.0),
            ),
            TextField(
              minLines: 1,
              maxLines: 4000000000,
              controller: _controller.noteTextController,
              focusNode: _controller.noteFocusNode,
              decoration: const InputDecoration(
                hintText: "Type your note...",
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
