import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class NoteCard extends StatelessWidget {
  final int index;

  NoteCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
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
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      controller.notes[index].title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : const SizedBox.shrink(),
            controller.notes[index].note.isNotEmpty
                ? Expanded(
                    child: Text(
                      controller.notes[index].note,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                controller.notes[index].dateTime.toString(),
                style: const TextStyle(fontSize: 10.0, color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
