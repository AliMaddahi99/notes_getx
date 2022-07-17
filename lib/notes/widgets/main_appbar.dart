import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/notes/controllers/note_controller.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({Key? key}) : super(key: key);

  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(
        alignment: Alignment.centerRight,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _controller.pageViewId.value = 0;
                    _controller.pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  icon: Icon(
                    _controller.pageViewId.value == 0
                        ? Icons.book_rounded
                        : Icons.book_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _controller.pageViewId.value = 1;
                    _controller.pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                  icon: Icon(
                    _controller.pageViewId.value == 1
                        ? Icons.check_box_rounded
                        : Icons.check_box_outlined,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => _controller.pageViewId.value == 0
                ? IconButton(
                    onPressed: () {
                      _controller.isGridView.value =
                          !_controller.isGridView.value;
                    },
                    icon: _controller.isGridView.value
                        ? const Icon(Icons.view_list_rounded)
                        : const Icon(Icons.grid_view_rounded),
                    tooltip: _controller.isGridView.value
                        ? "List view"
                        : "Grid view",
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
