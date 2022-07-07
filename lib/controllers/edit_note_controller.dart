import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_getx/controllers/note_controller.dart';

class EditNoteController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();

  final NoteController controller = Get.find();
  var args = Get.arguments;

  @override
  void onInit() {
    titleTextController.text = controller.notes[args].title!;
    noteTextController.text = controller.notes[args].note;
    super.onInit();
  }
}
