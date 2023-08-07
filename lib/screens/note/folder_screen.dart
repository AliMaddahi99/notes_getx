import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/widgets/app/add_fab.dart';
import 'package:notes_getx/widgets/note/folder/folder_screen_main_app_bar.dart';
import 'package:notes_getx/widgets/app/select_mode_app_bar.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_bar/select_mode_bottom_bar.dart';
import 'package:notes_getx/widgets/note/stream_builder_masonry_grid_view.dart';

class FolderScreen extends StatelessWidget {
  final String folderName;
  FolderScreen({
    Key? key,
    required this.folderName,
  }) : super(key: key);

  final AppController _appController = Get.find();

  Stream<List<Note>> getFolderNotes() {
    return _appController.db.notes
        .where()
        .filter()
        .folderNameEqualTo(folderName)
        .and()
        .isFolderEqualTo(false)
        .build()
        .watch(fireImmediately: true);
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
                  ? SelectModeAppBar(folderName: folderName)
                  : FolderScreenMainAppBar(folderName: folderName),
            ),
          ),
        ),
        body: StreamBuilderMasonryGridView(
          stream: getFolderNotes(),
          returnCard: ReturnCard.noteCard,
        ),
        floatingActionButton: AddFAB(
          onPressed: () => {
            Get.to(
              () => AddEditNote(folderName: folderName),
              transition: Transition.cupertino,
            ),
          },
          tooltip: "add_note".tr,
        ),
        bottomNavigationBar: Obx(
          () => Container(
            child: _appController.isSelectMode.value
                ? SelectModeBottomBar(
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
