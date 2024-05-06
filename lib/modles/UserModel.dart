class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String userType;
  String password;
  String ownerId;
  String identityId;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.userType,
      required this.password,
      this.ownerId = "",
      this.identityId = ""});

  factory UserModel.fromJson(Map json) {
    return UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        userType: json["userType"],
        password: json["password"],
        ownerId: json["ownerId"] == "" || json["ownerId"] == null
            ? ""
            : json["ownerId"],
        identityId: json["identityId"] == "" || json["identityId"] == null
            ? ""
            : json["identityId"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "userType": userType,
        "password": password,
        "ownerId": ownerId,
        "identityId": identityId
      };
}
