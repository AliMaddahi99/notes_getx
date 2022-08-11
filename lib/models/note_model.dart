class NoteModel {
  int id;
  String title;
  String note;
  String dateTime;
  String folder;

  NoteModel({
    required this.id,
    required this.title,
    required this.note,
    required this.dateTime,
    required this.folder,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        dateTime: json["dateTime"],
        folder: json["folder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "dateTime": dateTime,
        "folder": folder,
      };
}
