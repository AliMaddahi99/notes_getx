import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/notes/controllers/note_controller.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({Key? key}) : super(key: key);

  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Notes Getx"),
      actions: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                _controller.isGridView.value = !_controller.isGridView.value;
              },
              icon: _controller.isGridView.value
                  ? const Icon(Icons.view_list_rounded)
                  : const Icon(Icons.grid_view_rounded),
              tooltip: _controller.isGridView.value ? "List view" : "Grid view",
            ),
          ),
        ),
      ],
    );
  }
}
