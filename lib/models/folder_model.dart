class FolderModel {
  final String name;
  final List notes;

  FolderModel({required this.name, required this.notes});

  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      name: json["name"],
      notes: json["notes"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "notes": notes,
    };
  }
}
