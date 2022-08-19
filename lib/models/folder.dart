import 'package:notes_getx/models/note.dart';

class Folder {
  final String name;
  final List<Note> notes;

  Folder({required this.name, required this.notes});

  factory Folder.fromMap(Map<String, dynamic> folderAsMap) {
    return Folder(
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
