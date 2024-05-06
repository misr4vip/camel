class ShepherdModel {
  String id;
  String name;
  String identityId;
  String camelCounts;
  String mobile;

  ShepherdModel(
      {required this.id,
      required this.name,
      required this.identityId,
      required this.camelCounts,
      required this.mobile});

  factory ShepherdModel.fromJson(Map json) {
    return ShepherdModel(
      id: json["id"],
      name: json["name"],
      identityId: json["identityId"],
      camelCounts: json["camelCounts"],
      mobile: json["mobile"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "identityId": identityId,
        "camelCounts": camelCounts,
        "mobile": mobile,
      };
}
