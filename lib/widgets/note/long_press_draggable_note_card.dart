import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/widgets/note/note_card.dart';

class LongPressDraggableNoteCard extends StatelessWidget {
  final Note note;
  final bool highlighted;

  LongPressDraggableNoteCard({
    super.key,
    required this.note,
    required this.highlighted,
  });

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      onDragStarted: () {
        _appController.isSelectMode.value = true;
        _appController.selectItem(note.id);
      },
      onDragUpdate: (details) {
        _appController.selectedItems.clear();

        if (details.globalPosition.dy < 100) {
          _noteController.scrollController.animateTo(
            _noteController.scrollController.offset - 50,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else if (details.globalPosition.dy >
            MediaQuery.of(context).size.height - 100) {
          _noteController.scrollController.animateTo(
            _noteController.scrollController.offset + 50,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        }
      },
      data: note,
      childWhenDragging: Opacity(
        opacity: 0.0,
        child: NoteCard(
          note: note,
        ),
      ),
      feedback: SizedBox(
        // using MediaQuery to set NoteCard width, otherwise,
        // it's width would be as long as NoteCard content
        width: _noteController.isGridView.value
            ? MediaQuery.of(context).size.width / 2 - 8
            : MediaQuery.of(context).size.width - 16,
        child: NoteCard(
          note: note,
        ),
      ),
      child: NoteCard(
        note: note,
        highlighted: highlighted,
      ),
    );
  }
}
