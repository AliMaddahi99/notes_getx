import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/note/view_note_card.dart';

class NoteHome extends StatelessWidget {
  NoteHome({Key? key}) : super(key: key);

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: ViewNoteCard(),
        floatingActionButton: !_appController.isSelectMode.value
            ? FloatingActionButton(
                onPressed: () => {
                  Get.to(
                    () => AddEditNote(),
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
