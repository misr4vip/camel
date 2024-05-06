class ReminderModel {
  String id;
  String title;
  String note;
  int color;
  int dateTime;

  ReminderModel({
    required this.id,
    required this.title,
    required this.note,
    required this.color,
    required this.dateTime,
  });

  factory ReminderModel.fromJson(Map json) {
    return ReminderModel(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        color: json["color"],
        dateTime: json["dateTime"]);
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "color": color,
        "dateTime": dateTime
      };
}
