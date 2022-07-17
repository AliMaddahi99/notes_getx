import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/notes/controllers/note_controller.dart';
import 'package:notes_getx/notes/screens/add_edit_note.dart';
import 'package:notes_getx/notes/widgets/no_note.dart';
import 'package:notes_getx/tasks/screens/task_app.dart';
import 'package:notes_getx/notes/widgets/gridview_note_card.dart';
import 'package:notes_getx/notes/widgets/listview_note_card.dart';
import 'package:notes_getx/notes/widgets/main_appbar.dart';
import 'package:notes_getx/notes/widgets/select_mode_app_bar.dart';
import 'package:notes_getx/notes/widgets/select_mode_bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NoteController _controller = Get.put(NoteController());

  final PageController _pageController = PageController();

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
          body: PageView(
            controller: _pageController,
            children: [
              _controller.notes.isNotEmpty
                  ? _controller.isGridView.value
                      ? GridViewNoteCard()
                      : ListViewNoteCard()
                  : const NoNote(),
              const TaskApp(),
            ],
          ),
          bottomNavigationBar: _controller.isSelectMode.value
              ? SelectModeBottomNavigationBar()
              : const SizedBox.shrink(),
          floatingActionButton: !_controller.isSelectMode.value
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
