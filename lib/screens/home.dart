import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/screens/add_edit_note.dart';
import 'package:notes_getx/widgets/gridview_note_card.dart';
import 'package:notes_getx/widgets/listview_note_card.dart';
import 'package:notes_getx/widgets/main_appbar.dart';
import 'package:notes_getx/widgets/select_mode_app_bar.dart';

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
          body: _controller.notes.isNotEmpty
              ? _controller.isGridView.value
                  ? GridViewNoteCard()
                  : ListViewNoteCard()
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Icon(
                          Icons.note_alt_rounded,
                          size: 56.0,
                          color: Colors.amber.shade200,
                        ),
                      ),
                      const Text(
                        "No notes here yet",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: !_controller.isSelectMode.value
              ? FloatingActionButton(
                  onPressed: () => {
                    Get.to(
                      () => AddEditNote(),
                      transition: Transition.cupertino,
                    ),
                  },
                  tooltip: "Add note",
                  child: const Icon(Icons.add),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
