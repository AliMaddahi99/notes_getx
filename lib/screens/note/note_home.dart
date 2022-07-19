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

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NoteController _controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          if (_controller.isSelectMode.value) {
            _controller.selectedNote.clear();
            _controller.isSelectMode.value = false;
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: _controller.isSelectMode.value
                ? SelectModeAppBar()
                : MainAppBar(),
          ),
          body: !_controller.isSelectMode.value
              ? PageView(
                  onPageChanged: (value) {
                    _controller.pageViewId.value = value;
                  },
                  controller: _controller.pageController,
                  children: [
                    _controller.notes.isNotEmpty
                        ? _controller.isGridView.value
                            ? GridViewNoteCard()
                            : ListViewNoteCard()
                        : const NoNote(),
                    TaskApp(),
                  ],
                )
              : _controller.notes.isNotEmpty
                  ? _controller.isGridView.value
                      ? GridViewNoteCard()
                      : ListViewNoteCard()
                  : const NoNote(),
          bottomNavigationBar: _controller.isSelectMode.value
              ? SelectModeBottomNavigationBar()
              : const SizedBox.shrink(),
          floatingActionButton: (!_controller.isSelectMode.value &&
                  _controller.pageViewId.value == 0)
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
