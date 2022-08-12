import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';

class NoteCard extends StatelessWidget {
  final int index;
  final bool highlighted;
  final bool isFolder;
  NoteCard({
    Key? key,
    required this.index,
    this.highlighted = false,
    this.isFolder = false,
  }) : super(key: key);

  final AppController _appController = Get.find();
  final NoteController _noteController = Get.find();
  final FolderController _folderController = Get.find();

  String getNoteCountInFolder() {
    var f = _folderController.folders.singleWhere(
        (folder) => folder.name == _noteController.notes[index].folderName);
    return f.notes.length.toString();
  }

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
                onTap: _noteController.notes[index].isFolder
                    ? () {
                        if (_appController.isSelectMode.value) {
                          _appController
                              .selectItem(_noteController.notes[index].id);
                        } else {}
                      }
                    : () {
                        if (_appController.isSelectMode.value) {
                          _appController
                              .selectItem(_noteController.notes[index].id);
                        } else {
                          _appController.selectedItems.clear();
                          _appController
                              .selectItem(_noteController.notes[index].id);
                          Get.to(
                            () => AddEditNote(),
                            arguments: index,
                          );
                        }
                      },
                onLongPress: isFolder
                    ? () {
                        _appController.isSelectMode.value = true;
                        _appController
                            .selectItem(_noteController.notes[index].id);
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isFolder
                      ? Row(
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
                                            _noteController
                                                .notes[index].folderName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            getNoteCountInFolder(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        _noteController.notes[index].folderName,
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
                                      getNoteCountInFolder(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _noteController.notes[index].title.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8.0,
                                    ),
                                    child: Text(
                                      _noteController.notes[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            _noteController.notes[index].note.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8.0,
                                    ),
                                    child: Text(
                                      _noteController.notes[index].note,
                                      maxLines: _noteController.isGridView.value
                                          ? 4
                                          : 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            _noteController.isGridView.value
                                                ? 16.0
                                                : 18.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Padding(
                              padding: EdgeInsets.only(
                                top:
                                    _noteController.isGridView.value ? 16.0 : 0,
                              ),
                              child: Text(
                                _noteController.notes[index].dateTime
                                    .toString(),
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
          Obx(
            () => Visibility(
              visible: _appController.isSelectMode.value,
              child: Transform.scale(
                scale: 1.3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Checkbox(
                    splashRadius: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    value: _appController.selectedItems
                        .contains(_noteController.notes[index].id),
                    onChanged: (checked) {
                      _appController
                          .selectItem(_noteController.notes[index].id);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
