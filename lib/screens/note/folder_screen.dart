import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/app/no_item.dart';
import 'package:notes_getx/widgets/note/folder_screen_main_app_bar.dart';
import 'package:notes_getx/widgets/note/note_card.dart';
import 'package:notes_getx/widgets/app/select_mode_app_bar.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_navigation_bar/select_mode_bottom_navigation_bar.dart';

class FolderScreen extends StatelessWidget {
  final String folderName;
  FolderScreen({
    Key? key,
    required this.folderName,
  }) : super(key: key);

  final AppController _appController = Get.find();
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

  Stream<List<Note>> getFolderNotes() {
    return _appController.db.notes
        .where()
        .filter()
        .folderNameEqualTo(folderName)
        .and()
        .isFolderEqualTo(false)
        .build()
        .watch(initialReturn: true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_appController.isSelectMode.value) {
          _appController.selectedItems.clear();
          _appController.selectedFolderNotes.clear();
          _appController.isSelectMode.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(
            () => Container(
              child: _appController.isSelectMode.value
                  ? SelectModeAppBar(
                      folderName: folderName,
                    )
                  : FolderScreenMainAppBar(folderName: folderName),
            ),
          ),
        ),
        body: StreamBuilder<List<Note>>(
          initialData: const [],
          stream: getFolderNotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            return snapshot.data!.isEmpty
                ? NoItem()
                : Obx(
                    () => MasonryGridView.count(
                      padding: const EdgeInsets.all(8.0),
                      crossAxisCount: gridCrossAxisCount(context),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // show the list in reverse order,
                        // so the last item that is added,
                        // placed at index 0 in MasonryGridView
                        int reversedIndex = snapshot.data!.length - 1 - index;

                        return NoteCard(
                          note: snapshot.data![reversedIndex],
                        );
                      },
                    ),
                  );
          },
        ),
        floatingActionButton: Obx(
          () => Container(
            child: !_appController.isSelectMode.value
                ? FloatingActionButton(
                    onPressed: () => {
                      Get.to(
                        () => AddEditNote(
                          folderName: folderName,
                        ),
                        transition: Transition.cupertino,
                      ),
                    },
                    tooltip: "Add note",
                    child: const Icon(Icons.add_rounded),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            child: _appController.isSelectMode.value
                ? SelectModeBottomNavigationBar(
                    deleteFromFolderScreen: true,
                    folderName: folderName,
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
