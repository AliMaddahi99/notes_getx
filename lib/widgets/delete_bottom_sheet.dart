import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class DeleteBottomSheet extends StatelessWidget {
  DeleteBottomSheet({Key? key}) : super(key: key);

  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Delete note",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Delete ${_controller.getSelectedNotesCount()}?",
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onPressed: () {
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onPressed: () {
                  for (var n in _controller.selectedNote) {
                    _controller.deleteNote(n);
                  }
                  _controller.selectedNote.clear();
                  _controller.isSelectMode.value = false;
                  Get.back();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
