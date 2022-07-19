import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/widgets/note/delete_bottom_sheet.dart';

class SelectModeBottomNavigationBar extends StatelessWidget {
  SelectModeBottomNavigationBar({Key? key}) : super(key: key);

  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: Colors.amber,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: _controller.selectedNote.isNotEmpty
                  ? () {
                      Get.bottomSheet(
                        DeleteBottomSheet(
                          message:
                              "Delete ${_controller.getSelectedNotesCount()}?",
                        ),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.delete_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
