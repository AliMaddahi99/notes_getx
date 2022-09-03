import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/widgets/app/no_item.dart';
import 'package:notes_getx/widgets/note/drag_target_card.dart';
import 'package:notes_getx/widgets/note/note_card.dart';

enum ReturnCard { dragTargetCard, noteCard }

class StreamBuilderMasonryGridView extends StatelessWidget {
  final Stream<List<Note>> stream;
  final ReturnCard returnCard;
  final bool isViewNoteCard;

  StreamBuilderMasonryGridView({
    super.key,
    required this.stream,
    required this.returnCard,
    this.isViewNoteCard = false,
  });

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
    return StreamBuilder<List<Note>>(
      initialData: const [],
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        return snapshot.data!.isEmpty
            ? NoItem()
            : Obx(
                () => MasonryGridView.count(
                  key: isViewNoteCard
                      ? const PageStorageKey<String>("notesPage")
                      : null,
                  controller:
                      isViewNoteCard ? _noteController.scrollController : null,
                  cacheExtent: isViewNoteCard ? 500 : null,
                  padding: const EdgeInsets.all(8.0),
                  crossAxisCount: gridCrossAxisCount(context),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // show the list in reverse order,
                    // so the last item that is added,
                    // placed at index 0 in MasonryGridView
                    int reversedIndex = snapshot.data!.length - 1 - index;

                    switch (returnCard) {
                      case ReturnCard.dragTargetCard:
                        return DragTargetCard(
                            note: snapshot.data![reversedIndex]);
                      case ReturnCard.noteCard:
                        return NoteCard(note: snapshot.data![reversedIndex]);
                    }
                  },
                ),
              );
      },
    );
  }
}
