import 'package:notes_getx/models/note_model.dart';

class FolderModel {
  final String name;
  final List<NoteModel> notes;

  FolderModel({required this.name, required this.notes});
}
