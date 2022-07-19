class TaskModel {
  int id;
  String title;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      TaskModel(id: json["id"], title: json["title"], isDone: json["isDone"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title, "isDone": isDone};
}
