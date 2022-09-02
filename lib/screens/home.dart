import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/folder_controller.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/controllers/task/task_controller.dart';
import 'package:notes_getx/screens/note/note_home.dart';
import 'package:notes_getx/screens/task/task_home.dart';
import 'package:notes_getx/widgets/app/main_appbar.dart';
import 'package:notes_getx/widgets/app/select_mode_app_bar.dart';
import 'package:notes_getx/widgets/app/select_mode_bottom_navigation_bar/select_mode_bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  // AppController is Get.find() because it's Get.put() in database.dart
  final AppController _appController = Get.find();
  final NoteController _noteController = Get.put(NoteController());
  final TaskController _taskController = Get.put(TaskController());
  final FolderController _folderController = Get.put(FolderController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
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
            child: _appController.isSelectMode.value
                ? SelectModeAppBar()
                : MainAppBar(),
          ),
          body: PageView(
            physics: _appController.isSelectMode.value
                ? const NeverScrollableScrollPhysics()
                : const PageScrollPhysics(),
            onPageChanged: (value) {
              _appController.pageViewId.value = value;
            },
            controller: _appController.pageController,
            children: [
              NoteHome(),
              TaskHome(),
            ],
          ),
          bottomNavigationBar: _appController.isSelectMode.value
              ? SelectModeBottomNavigationBar()
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
