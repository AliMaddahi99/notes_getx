import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/widgets/note/note_card.dart';

class ListViewNoteCard extends StatelessWidget {
  ListViewNoteCard({Key? key}) : super(key: key);

  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 300),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: NoteCard(index: index),
                ),
              ),
            ),
          );
        },
        itemCount: _noteController.notes.length,
      ),
    );
  }
}
