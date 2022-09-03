import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/widgets/app/no_item.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet.dart';
import 'package:notes_getx/widgets/note/folder/folder_card.dart';
import 'package:notes_getx/widgets/note/long_press_draggable_note_card.dart';

class ViewNoteCard extends StatelessWidget {
  ViewNoteCard({Key? key}) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();
  final FolderController _folderController = Get.find();

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
    return StreamBuilder<List<Note>>(
      initialData: const [],
      stream: getNotes(),
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        return snapshot.data!.isEmpty
            ? NoItem()
            : Obx(
                () => MasonryGridView.count(
                  cacheExtent: 500,
                  controller: _noteController.scrollController,
                  key: const PageStorageKey<String>("notesPage"),
                  padding: const EdgeInsets.all(8.0),
                  crossAxisCount: gridCrossAxisCount(context),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // show the list in reverse order,
                    // so the last item that is added,
                    // placed at index 0 in MasonryGridView
                    int reversedIndex = snapshot.data!.length - 1 - index;
                    return DragTarget(
                      builder: (context, candidateData, rejectedData) {
                        return snapshot.data![reversedIndex].isFolder
                            ? FolderCard(
                                note: snapshot.data![reversedIndex],
                                highlighted: candidateData.isNotEmpty,
                              )
                            : LongPressDraggableNoteCard(
                                note: snapshot.data![reversedIndex],
                                highlighted: candidateData.isNotEmpty,
                              );
                      },
                      onWillAccept: (data) {
                        return (data as Note).id !=
                            snapshot.data![reversedIndex].id;
                      },
                      onAccept: (data) {
                        if (snapshot.data![reversedIndex].isFolder) {
                          _folderController.addNoteToExistingFolder(
                            snapshot.data![reversedIndex].folderName!,
                            data as Note,
                          );
                          _appController.isSelectMode.value = false;
                        } else {
                          Get.bottomSheet(
                            FolderBottomSheet(
                              title: "New Folder",
                              targetNote: snapshot.data![reversedIndex],
                              draggingNote: data as Note,
                            ),
                            enableDrag: false,
                            isDismissible: false,
                          );
                        }
                      },
                    );
                  },
                ),
              );
      },
    );
  }
}
