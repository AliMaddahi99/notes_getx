import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';
import 'package:notes_getx/screens/edit_note.dart';

class NoteCard extends StatelessWidget {
  final int index;
  NoteCard({Key? key, required this.index}) : super(key: key);

  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Obx(
        () => InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(16.0),
          onTap: () {
            _controller.isSelectMode.value
                ? _controller.selectNote(_controller.notes[index].id)
                : Get.to(() => EditNote(), arguments: index);
          },
          onLongPress: () {
            _controller.isSelectMode.value = true;
            _controller.selectNote(_controller.notes[index].id);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _controller.notes[index].title!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Text(
                          _controller.notes[index].title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                _controller.notes[index].note.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Text(
                          _controller.notes[index].note,
                          maxLines: _controller.isGridView.value ? 4 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize:
                                _controller.isGridView.value ? 16.0 : 18.0,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.only(
                    top: _controller.isGridView.value ? 16.0 : 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _controller.notes[index].dateTime.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black45,
                        ),
                      ),
                      Visibility(
                        visible: _controller.isSelectMode.value,
                        child: Transform.scale(
                          scale: 1.3,
                          child: SizedBox(
                            height: 0,
                            width: 16,
                            child: Checkbox(
                                splashRadius: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                value: _controller.selectedNote
                                    .contains(_controller.notes[index].id),
                                onChanged: (checked) {
                                  _controller
                                      .selectNote(_controller.notes[index].id);
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
