import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/services/database/note_database_service.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/note_page/move_to_bottom_sheet/move_to_card.dart';
import 'package:notes_getx/widgets/note/folder/folder_bottom_sheet.dart';

class MoveToBottomSheet extends StatelessWidget {
  final bool deleteFromFolderScreen;
  final String? folderName;

  MoveToBottomSheet({
    super.key,
    required this.deleteFromFolderScreen,
    required this.folderName,
  });

  final AppController _appController = Get.find();
  final FolderController _folderController = Get.find();

  int gridCrossAxisCount(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var count = width > 768 ? 4 : 2;

    return count;
  }

  Stream<List<Note>> getFolders() {
    return _appController.db.notes
        .where()
        .filter()
        .isFolderEqualTo(true)
        .build()
        .watch(initialReturn: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Note>>(
      initialData: const [],
      stream: getFolders(),
      builder: (context, snapshot) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Select folder",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCrossAxisCount(context),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 16.0,
                    mainAxisExtent: 180.0,
                  ),
                  itemCount: 2 + snapshot.data!.length,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return MoveToCard(
                          icon: Icons.create_new_folder_rounded,
                          title: "New folder",
                          onTap: () async {
                            var selectedNotes = await NoteDatabaseService()
                                .getNotesFromDb(
                                    _appController.selectedItems.toList());

                            // selectedNotes is nullable so turn it to non null
                            List<Note> selectedNotesWithoutNull =
                                selectedNotes.whereType<Note>().toList();

                            Get.bottomSheet(
                              FolderBottomSheet(
                                title: "New folder",
                                notes: selectedNotesWithoutNull,
                                fromMoveToBottomSheet: true,
                                folderName: folderName,
                              ),
                              enableDrag: false,
                              isDismissible: false,
                            );
                          },
                        );
                      case 1:
                        return Visibility(
                          visible: deleteFromFolderScreen,
                          child: MoveToCard(
                            icon: Icons.turn_left_rounded,
                            title: "Parent folder",
                            onTap: () async {
                              List<Note?> selectedNotes =
                                  await NoteDatabaseService().getNotesFromDb(
                                      _appController.selectedItems().toList());

                              // selectedNotes is nullable so turn it to non null
                              List<Note> selectedNotesWithoutNull =
                                  selectedNotes.whereType<Note>().toList();

                              for (Note n in selectedNotesWithoutNull) {
                                n.folderName = null;
                              }

                              await NoteDatabaseService()
                                  .updateNotesInDb(selectedNotesWithoutNull);

                              // Get notes in the folder, if there isn't any note, delete the folder
                              var notesInFolder = await _appController.db.notes
                                  .where()
                                  .filter()
                                  .folderNameEqualTo(folderName)
                                  .findAll();

                              if (notesInFolder.length < 2) {
                                await NoteDatabaseService().deleteNotesFromDb([
                                  notesInFolder.first.id,
                                ]);
                                Get.back();
                              }

                              _appController.selectedItems.clear();
                              _appController.selectedFolderNotes.clear();
                              Get.back();
                              _appController.isSelectMode.value = false;
                            },
                          ),
                        );
                      default:
                        Future<int> getNotesInFolderCount() =>
                            _appController.db.notes
                                .where()
                                .filter()
                                .folderNameEqualTo(
                                    snapshot.data![index - 2].folderName)
                                .and()
                                .isFolderEqualTo(false)
                                .count();

                        return FutureBuilder<int>(
                          future: getNotesInFolderCount(),
                          initialData: 0,
                          builder: (BuildContext context,
                              AsyncSnapshot<int> noteCount) {
                            return MoveToCard(
                              icon: Icons.folder_rounded,
                              title: snapshot.data![index - 2].folderName!,
                              notesInFolderCount: noteCount.data!.toString(),
                              onTap: () async {
                                List<Note?> selectedNotes =
                                    await NoteDatabaseService().getNotesFromDb(
                                        _appController
                                            .selectedItems()
                                            .toList());

                                // selectedNotes is nullable so turn it to non null
                                List<Note> selectedNotesWithoutNull =
                                    selectedNotes.whereType<Note>().toList();

                                await _folderController.addNoteToExistingFolder(
                                    snapshot.data![index - 2].folderName!,
                                    selectedNotesWithoutNull);

                                _appController.selectedItems.clear();
                                _appController.selectedFolderNotes.clear();
                                Get.back();
                                _appController.isSelectMode.value = false;

                                // Get notes in the folder, if there isn't any note, delete the folder
                                var notesInFolder = await _appController
                                    .db.notes
                                    .where()
                                    .filter()
                                    .folderNameEqualTo(folderName)
                                    .findAll();

                                if (notesInFolder.length < 2) {
                                  await NoteDatabaseService()
                                      .deleteNotesFromDb([
                                    notesInFolder.first.id,
                                  ]);
                                  Get.back();
                                }
                              },
                            );
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
