import 'package:notes_getx/models/note_model.dart';

class FolderModel {
  final String name;
  final List<NoteModel> notes;

  FolderModel({required this.name, required this.notes});

  factory FolderModel.fromMap(Map<String, dynamic> json) {
    return FolderModel(
      name: json["name"],
      notes:
          List<NoteModel>.from(json['notes'].map((n) => NoteModel.fromMap(n))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "notes": notes,
    };
  }
}
