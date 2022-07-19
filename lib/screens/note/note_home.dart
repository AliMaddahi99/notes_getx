import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note/note_controller.dart';
import 'package:notes_getx/screens/note/add_edit_note.dart';
import 'package:notes_getx/screens/task/task_home.dart';
import 'package:notes_getx/widgets/note/no_note.dart';
import 'package:notes_getx/widgets/note/gridview_note_card.dart';
import 'package:notes_getx/widgets/note/listview_note_card.dart';
import 'package:notes_getx/widgets/note/main_appbar.dart';
import 'package:notes_getx/widgets/note/select_mode_app_bar.dart';
import 'package:notes_getx/widgets/note/select_mode_bottom_navigation_bar.dart';

class NoteHome extends StatelessWidget {
  NoteHome({Key? key}) : super(key: key);

  final NoteController _noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          if (_noteController.isSelectMode.value) {
            _noteController.selectedNote.clear();
            _noteController.isSelectMode.value = false;
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: _noteController.isSelectMode.value
                ? SelectModeAppBar()
                : MainAppBar(),
          ),
          body: !_noteController.isSelectMode.value
              ? PageView(
                  onPageChanged: (value) {
                    _noteController.pageViewId.value = value;
                  },
                  controller: _noteController.pageController,
                  children: [
                    _noteController.notes.isNotEmpty
                        ? _noteController.isGridView.value
                            ? GridViewNoteCard()
                            : ListViewNoteCard()
                        : const NoNote(),
                    TaskHome(),
                  ],
                )
              : _noteController.notes.isNotEmpty
                  ? _noteController.isGridView.value
                      ? GridViewNoteCard()
                      : ListViewNoteCard()
                  : const NoNote(),
          bottomNavigationBar: _noteController.isSelectMode.value
              ? SelectModeBottomNavigationBar()
              : const SizedBox.shrink(),
          floatingActionButton: (!_noteController.isSelectMode.value &&
                  _noteController.pageViewId.value == 0)
              ? FloatingActionButton(
                  onPressed: () => {
                    Get.to(
                      () => AddEditNote(),
                      transition: Transition.cupertino,
                    ),
                  },
                  tooltip: "Add note",
                  child: const Icon(Icons.add_rounded),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
