class NoteModel {
  int id;
  String? title;
  String note;
  DateTime dateTime;

  NoteModel({
    required this.id,
    this.title,
    required this.note,
    required this.dateTime,
  });
}
