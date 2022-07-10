import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/screens/edit_note.dart';
import 'package:notes_getx/widgets/delete_dialog.dart';

class GridViewNoteCard extends StatelessWidget {
  GridViewNoteCard({Key? key}) : super(key: key);

  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Obx(
          () => AnimationLimiter(
            child: MasonryGridView.count(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: constraints.maxWidth > 768 ? 4 : 2,
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: constraints.maxWidth > 768 ? 4 : 2,
                    position: index,
                    duration: const Duration(milliseconds: 300),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: InkWell(
                            mouseCursor: SystemMouseCursors.click,
                            borderRadius: BorderRadius.circular(16.0),
                            onTap: () {
                              Get.to(() => EditNote(), arguments: index);
                            },
                            onLongPress: () {
                              Get.dialog(DeleteDialog(index: index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller.notes[index].title!.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            controller.notes[index].title!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  controller.notes[index].note.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            controller.notes[index].note,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                    ),
                                    child: Text(
                                      controller.notes[index].dateTime
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
