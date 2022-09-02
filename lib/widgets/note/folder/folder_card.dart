import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/folder_screen.dart';
import 'package:notes_getx/widgets/app/card_checkbox.dart';

class FolderCard extends StatelessWidget {
  final Note note;
  final bool highlighted;
  FolderCard({
    Key? key,
    required this.note,
    this.highlighted = false,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();

  Stream<List<Note>> getNotesInFolder() {
    return _appController.db.notes
        .where()
        .filter()
        .folderNameEqualTo(note.folderName!)
        .and()
        .isFolderEqualTo(false)
        .watch(initialReturn: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: StreamBuilder<List<Note>>(
        initialData: const [],
        stream: getNotesInFolder(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          return Stack(
            alignment: _noteController.isGridView.value
                ? Alignment.bottomRight
                : Alignment.centerRight,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(
                    color: highlighted ? Colors.amber : Colors.transparent,
                  ),
                ),
                child: Obx(
                  () => InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: () {
                      if (_appController.isSelectMode.value) {
                        _appController.selectItem(note.id);

                        for (var noteInFolder in snapshot.data!) {
                          _appController.selectFolderNotes(noteInFolder.id);
                        }
                      } else {
                        Get.to(
                          () => FolderScreen(
                            folderName: note.folderName!,
                          ),
                          transition: Transition.cupertino,
                        );
                      }
                    },
                    onLongPress: () {
                      _appController.isSelectMode.value = true;
                      _appController.selectItem(note.id);

                      for (var noteInFolder in snapshot.data!) {
                        _appController.selectFolderNotes(noteInFolder.id);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.folder_rounded,
                            color: Colors.amber,
                            size: 32.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: _noteController.isGridView.value
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.folderName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.length.toString(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      note.folderName!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          !_noteController.isGridView.value
                              ? Padding(
                                  padding: _appController.isSelectMode.value
                                      ? const EdgeInsets.only(right: 40.0)
                                      : EdgeInsets.zero,
                                  child: Text(
                                    snapshot.data!.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CardCheckbox(itemId: note.id, isNoteOrFolderCard: true),
            ],
          );
        },
      ),
    );
  }
}
