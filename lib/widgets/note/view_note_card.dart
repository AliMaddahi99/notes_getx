import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/widgets/note/folder_bottom_sheet.dart';
import 'package:notes_getx/widgets/note/folder_card.dart';
import 'package:notes_getx/widgets/note/note_card.dart';

class ViewNoteCard extends StatelessWidget {
  ViewNoteCard({Key? key}) : super(key: key);

  final NoteController _noteController = Get.find();
  final AppController _appController = Get.find();
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

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MasonryGridView.count(
        cacheExtent: 500,
        controller: _noteController.scrollController,
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
                  child: DragTarget(
                    builder: (context, candidateData, rejectedData) {
                      return _noteController.notes[index].isFolder
                          ? FolderCard(
                              index: index,
                              highlighted: candidateData.isNotEmpty,
                            )
                          : LongPressDraggable(
                              onDragStarted: () {
                                _appController.isSelectMode.value = true;
                                _appController.selectItem(
                                    _noteController.notes[index].id);
                              },
                              onDragUpdate: (details) {
                                _appController.selectedItems.clear();

                                if (details.globalPosition.dy < 100) {
                                  _noteController.scrollController.animateTo(
                                    _noteController.scrollController.offset -
                                        50,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                } else if (details.globalPosition.dy >
                                    MediaQuery.of(context).size.height - 100) {
                                  _noteController.scrollController.animateTo(
                                    _noteController.scrollController.offset +
                                        50,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                }
                              },
                              data: _noteController.notes[index].id,
                              childWhenDragging: Opacity(
                                opacity: 0.0,
                                child: NoteCard(
                                  index: index,
                                ),
                              ),
                              feedback: SizedBox(
                                // using MediaQuery to set NoteCard width, otherwise,
                                // it's width would be as long as NoteCard content
                                width: _noteController.isGridView.value
                                    ? MediaQuery.of(context).size.width / 2 - 8
                                    : MediaQuery.of(context).size.width - 16,
                                child: NoteCard(
                                  index: index,
                                ),
                              ),
                              child: NoteCard(
                                index: index,
                                highlighted: candidateData.isNotEmpty,
                                isFolder: _noteController.notes[index].isFolder,
                              ),
                            );
                    },
                    onWillAccept: (data) {
                      return data != _noteController.notes[index].id;
                    },
                    onAccept: (data) {
                      if (_noteController.notes[index].isFolder) {
                        _folderController.addNoteToExistingFolder(
                          _noteController.notes[index].folderName,
                          _noteController.notes
                              .firstWhere((note) => note.id == data),
                        );
                      } else {
                        Get.bottomSheet(
                          FolderBottomSheet(
                            title: "New Folder",
                            targetNoteId: _noteController.notes[index].id,
                            draggingNoteId: data as int,
                          ),
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          enableDrag: false,
                          isDismissible: false,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
