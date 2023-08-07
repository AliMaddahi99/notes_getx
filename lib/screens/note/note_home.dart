import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:notes_getx/controllers/app_controller.dart';
import 'package:notes_getx/controllers/note/fab_animation_controller.dart';
import 'package:notes_getx/models/note.dart';
import 'package:notes_getx/widgets/note/fab_options_menu/overlay_fab_options_menu_screen.dart';
import 'package:notes_getx/widgets/note/stream_builder_masonry_grid_view.dart';

class NoteHome extends StatelessWidget {
  NoteHome({Key? key}) : super(key: key);

  final AppController _appController = Get.find();
  final FABAnimationContoller _fabAnimationController =
      Get.put(FABAnimationContoller());

  Stream<List<Note>> getNotes() {
    return _appController.db.notes
        .where()
        .filter()
        .folderNameIsNull()
        .or()
        .isFolderEqualTo(true)
        .build()
        .watch(fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilderMasonryGridView(
        stream: getNotes(),
        returnCard: ReturnCard.dragTargetCard,
        isViewNoteCard: true,
      ),
      floatingActionButton: Obx(
        () => !_appController.isSelectMode.value
            ? FloatingActionButton(
                tooltip: "options".tr,
                onPressed: () {
                  Get.to(
                    () => OverlayFABOptionsMenu(),
                    opaque: false,
                    transition: Transition.noTransition,
                  );

                  _fabAnimationController.doAnimation();
                },
                child: const Icon(Icons.more_vert_rounded),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
