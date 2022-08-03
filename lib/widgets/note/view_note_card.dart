import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/widgets/note/note_card.dart';

class ViewNoteCard extends StatelessWidget {
  ViewNoteCard({Key? key}) : super(key: key);

  final NoteController _noteController = Get.find();

  int gridCrossAxisCount(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var count = 1;

    if (_noteController.isGridView.value) {
      count = width > 768 ? 4 : 2;
    } else {
      count = 1;
    }

    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MasonryGridView.count(
        key: const PageStorageKey<String>("notesPage"),
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: gridCrossAxisCount(context),
        itemCount: _noteController.notes.length,
        itemBuilder: (context, index) {
          return AnimationLimiter(
            child: AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 300),
              columnCount: gridCrossAxisCount(context),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: NoteCard(index: index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
