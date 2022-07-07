import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/screens/add_note.dart';
import 'package:notes_getx/widgets/gridview_note_card.dart';
import 'package:notes_getx/widgets/listview_note_card.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NoteController controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Getx"),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  controller.isGridView.value = !controller.isGridView.value;
                },
                icon: controller.isGridView.value
                    ? const Icon(Icons.view_list_rounded)
                    : const Icon(Icons.grid_view_rounded),
                tooltip:
                    controller.isGridView.value ? "List view" : "Grid view",
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.notes.isNotEmpty
            ? Container(
                child: controller.isGridView.value
                    ? GridViewNoteCard()
                    : ListViewNoteCard(),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Get.to(
            () => AddNote(),
            transition: Transition.cupertino,
          ),
        },
        tooltip: "Add note",
        child: const Icon(Icons.add),
      ),
    );
  }
}
