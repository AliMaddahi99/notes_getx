import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/app/card_checkbox.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final bool highlighted;
  NoteCard({
    Key? key,
    required this.note,
    this.highlighted = false,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
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
                  } else {
                    _appController.selectedItems.clear();
                    _appController.selectItem(note.id);
                    Get.to(
                      () => AddEditNote(),
                      arguments: note,
                      transition: Transition.cupertino,
                    );
                  }
                },
                onLongPress: note.folderName != null
                    ? () {
                        _appController.isSelectMode.value = true;
                        _appController.selectItem(note.id);
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      note.title.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                              ),
                              child: Text(
                                note.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      note.note.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                              ),
                              child: Text(
                                note.note,
                                maxLines:
                                    _noteController.isGridView.value ? 4 : 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: _noteController.isGridView.value
                                      ? 16.0
                                      : 18.0,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: _noteController.isGridView.value ? 16.0 : 0,
                        ),
                        child: Text(
                          note.dateTime,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      // Empty Row to override stack's width
                      Row(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CardCheckbox(itemId: note.id, isNoteOrFolderCard: true),
        ],
      ),
    );
  }
}
