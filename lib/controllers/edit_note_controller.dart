import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class EditNoteController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();

  final NoteController _controller = Get.find();
  var args = Get.arguments;

  void editNote() {
    var edited = _controller.notes[args];
    edited.title = titleTextController.text;
    edited.note = noteTextController.text;
    edited.dateTime = _controller.dateTimeNowStringify();
    _controller.notes[args] = edited;
  }

  @override
  void onInit() {
    titleTextController.text = _controller.notes[args].title!;
    noteTextController.text = _controller.notes[args].note;
    super.onInit();
  }
}
