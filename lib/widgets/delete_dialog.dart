import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class DeleteDialog extends StatelessWidget {
  final int index;
  DeleteDialog({Key? key, required this.index}) : super(key: key);

  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Do you want delete this note?"),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              controller.notes.removeAt(index);
              Get.back();
            },
            child: const Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
        ]);
  }
}
