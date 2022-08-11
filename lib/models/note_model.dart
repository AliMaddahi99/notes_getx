class NoteModel {
  int id;
  String title;
  String note;
  String dateTime;
  String folderName;
  bool isFolder;
  bool isInParentFolder;

  NoteModel({
    required this.id,
    required this.title,
    required this.note,
    required this.dateTime,
    required this.folderName,
    required this.isFolder,
    required this.isInParentFolder,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        dateTime: json["dateTime"],
        folderName: json["folderName"],
        isFolder: json["isFolder"],
        isInParentFolder: json["isInParentFolder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "dateTime": dateTime,
        "folderName": folderName,
        "isFolder": isFolder,
        "isInParentFolder": isInParentFolder,
      };
}
