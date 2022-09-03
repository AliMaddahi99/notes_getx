import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/app/add_fab.dart';
import 'package:notes_getx/widgets/note/stream_builder_masonry_grid_view.dart';

class NoteHome extends StatelessWidget {
  NoteHome({Key? key}) : super(key: key);

  final AppController _appController = Get.find();

  Stream<List<Note>> getNotes() {
    return _appController.db.notes
        .where()
        .filter()
        .folderNameIsNull()
        .or()
        .isFolderEqualTo(true)
        .build()
        .watch(initialReturn: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilderMasonryGridView(
        stream: getNotes(),
        returnCard: ReturnCard.dragTargetCard,
        isViewNoteCard: true,
      ),
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
