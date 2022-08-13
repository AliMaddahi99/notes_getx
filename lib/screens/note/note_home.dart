import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/no_item.dart';
import 'package:notes_getx/widgets/note/view_note_card.dart';

class NoteHome extends StatelessWidget {
  NoteHome({Key? key}) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _noteController.notes.isNotEmpty ? ViewNoteCard() : NoItem(),
        floatingActionButton: !_appController.isSelectMode.value
            ? FloatingActionButton(
                onPressed: () => {
                  Get.to(
                    () => AddEditNote(
                      folderName: "parent",
                    ),
                    transition: Transition.cupertino,
                  ),
                },
                tooltip: "Add note",
                child: const Icon(Icons.add_rounded),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
