class ShepherdReminderModel {
  String id;
  String title;
  String note;
  int color;
  int dateTime;
  String category;
  String shepherdId;

  ShepherdReminderModel({
    required this.id,
    required this.title,
    required this.note,
    required this.color,
    required this.dateTime,
    required this.category,
    required this.shepherdId,
  });

  factory ShepherdReminderModel.fromJson(Map json) {
    return ShepherdReminderModel(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        color: json["color"],
        dateTime: json["dateTime"],
        category: json["category"],
        shepherdId: json["shepherdId"]);
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "color": color,
        "dateTime": dateTime,
        "category": category,
        "shepherdId": shepherdId
      };
}
