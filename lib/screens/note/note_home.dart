import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/app/add_fab.dart';
import 'package:notes_getx/widgets/note/view_note_card.dart';

class NoteHome extends StatelessWidget {
  const NoteHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewNoteCard(),
      floatingActionButton: AddFAB(
        onPressed: () => {
          Get.to(
            () => AddEditNote(),
            transition: Transition.cupertino,
          ),
        },
        tooltip: "Add note",
      ),
    );
  }
}
