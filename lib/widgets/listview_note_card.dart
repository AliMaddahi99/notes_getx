import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/screens/edit_note.dart';

class ListViewNoteCard extends StatelessWidget {
  ListViewNoteCard({Key? key}) : super(key: key);

  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Get.to(() => EditNote(), arguments: index);
              },
              onLongPress: () {
                Get.dialog(AlertDialog(
                    title: const Text("Delete"),
                    content: const Text("Do you want delete this note?"),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          controller.notes.removeAt(index);
                          Get.back();
                        },
                        child: const Text("Delete"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Cancel"),
                      ),
                    ]));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.notes[index].title!.isNotEmpty
                          ? Text(
                              controller.notes[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          : const SizedBox.shrink(),
                      controller.notes[index].note.isNotEmpty
                          ? Text(
                              controller.notes[index].note,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        controller.notes[index].dateTime.toString(),
                        style: const TextStyle(
                            fontSize: 10.0, color: Colors.black45),
                      ),
                    ],
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