class ShepherdModel {
  String id;
  String name;
  String identityId;
  String camelCounts;

  ShepherdModel(
      {required this.id,
      required this.name,
      required this.identityId,
      required this.camelCounts});

  factory ShepherdModel.fromJson(Map json) {
    return ShepherdModel(
      id: json["id"],
      name: json["name"],
      identityId: json["identityId"],
      camelCounts: json["camelCounts"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "identityId": identityId,
        "camelCounts": camelCounts,
      };
}
