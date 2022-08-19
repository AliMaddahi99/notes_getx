class Note {
  int? id;
  String title;
  String note;
  String dateTime;
  String folderName;
  bool isFolder;

  Note({
    this.id,
    required this.title,
    required this.note,
    required this.dateTime,
    required this.folderName,
    required this.isFolder,
  });

  factory Note.fromMap(Map<String, dynamic> noteAsMap) {
    return Note(
      id: noteAsMap["id"],
      title: noteAsMap["title"],
      note: noteAsMap["note"],
      dateTime: noteAsMap["dateTime"],
      folderName: noteAsMap["folderName"],
      isFolder: noteAsMap["isFolder"] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "note": note,
      "dateTime": dateTime,
      "folderName": folderName,
      "isFolder": isFolder ? 1 : 0,
    };
  }
}
