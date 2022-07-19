import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/widgets/note/note_card.dart';

class GridViewNoteCard extends StatelessWidget {
  GridViewNoteCard({Key? key}) : super(key: key);

  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Obx(
          () => AnimationLimiter(
            child: MasonryGridView.count(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: constraints.maxWidth > 768 ? 4 : 2,
                itemCount: _noteController.notes.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: constraints.maxWidth > 768 ? 4 : 2,
                    position: index,
                    duration: const Duration(milliseconds: 300),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: NoteCard(index: index),
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
