import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/widgets/note/note_card.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folderName),
        actions: [
          Obx(
            () => _appController.pageViewId.value == 0
                ? IconButton(
                    onPressed: () {
                      _noteController.isGridView.value =
                          !_noteController.isGridView.value;
                    },
                    icon: _noteController.isGridView.value
                        ? const Icon(Icons.view_list_rounded)
                        : const Icon(Icons.grid_view_rounded),
                    tooltip: _noteController.isGridView.value
                        ? "List view"
                        : "Grid view",
                  )
                : const SizedBox.shrink(),
          ),
          PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            tooltip: "Options",
            onSelected: (value) {
              switch (value) {
                case "Rename":
                  break;
                case "Delete":
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {"Rename", "Delete"}.map((choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
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
            // return NoteCard(index: index);
            return Container(
              margin: const EdgeInsets.all(8.0),
              height: 50,
              color: Colors.amber,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
