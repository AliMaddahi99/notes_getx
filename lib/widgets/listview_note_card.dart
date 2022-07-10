import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/screens/edit_note.dart';
import 'package:notes_getx/widgets/delete_dialog.dart';

class ListViewNoteCard extends StatelessWidget {
  ListViewNoteCard({Key? key}) : super(key: key);

  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.notes[index].title!.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
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
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      controller.notes[index].note,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Text(
                              controller.notes[index].dateTime.toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: controller.notes.length,
      ),
    );
  }
}
