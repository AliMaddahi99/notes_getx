import 'package:notes_getx/models/note_model.dart';

class FolderModel {
  final String name;
  final List<NoteModel> notes;

  FolderModel({required this.name, required this.notes});

  factory FolderModel.fromMap(Map<String, dynamic> folderAsMap) {
    return FolderModel(
      name: folderAsMap["name"],
      notes: List<NoteModel>.from(
          folderAsMap['notes'].map((n) => NoteModel.fromMap(n))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "notes": notes,
    };
  }
}
