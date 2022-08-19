import 'package:notes_getx/models/note.dart';

class FolderModel {
  final String name;
  final List<Note> notes;

  FolderModel({required this.name, required this.notes});

  factory FolderModel.fromMap(Map<String, dynamic> folderAsMap) {
    return FolderModel(
      name: folderAsMap["name"],
      notes: List<Note>.from(folderAsMap['notes'].map((n) => Note.fromMap(n))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "notes": notes,
    };
  }
}
