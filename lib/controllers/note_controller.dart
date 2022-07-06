import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_getx/models/note_model.dart';

class NoteController extends GetxController {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();

  var notes = <NoteModel>[].obs;

  @override
  void onInit() {
    noteFocusNode.requestFocus();
    super.onInit();
  }
}
