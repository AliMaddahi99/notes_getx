import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/models/note_model.dart';
import 'package:notes_getx/widgets/note/folder_screen_main_app_bar.dart';
import 'package:notes_getx/widgets/note/note_card.dart';
import 'package:notes_getx/widgets/select_mode_app_bar.dart';
import 'package:notes_getx/widgets/select_mode_bottom_navigation_bar.dart';

class FolderScreen extends StatelessWidget {
  final String folderName;
  FolderScreen({
    Key? key,
    required this.folderName,
  }) : super(key: key);

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

  List<NoteModel> getNotesFromFolder() {
    List<NoteModel> notes = [];
    for (var folder in _folderController.folders) {
      if (folder.name == folderName) {
        notes = folder.notes;
      }
    }

    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Obx(
        () => MasonryGridView.count(
          padding: const EdgeInsets.all(8.0),
          crossAxisCount: gridCrossAxisCount(context),
          itemCount: _folderController.folders
              .firstWhere((folder) => folder.name == folderName)
              .notes
              .length,
          itemBuilder: (context, index) {
            return NoteCard(
              index: index,
              note: getNotesFromFolder()[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          child: _appController.isSelectMode.value
              ? SelectModeBottomNavigationBar()
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
