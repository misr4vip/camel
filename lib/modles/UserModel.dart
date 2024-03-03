class UserModel{
  String id;
  String name;
  String email;
  String phone;
  String userType;
  String password;
  UserModel({required this.id ,required this.name , required this.email , required this.phone ,required this.userType, required this.password});

  factory UserModel.fromJson(Map json) {
    return UserModel(
        id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
        userType: json["userType"],
        password: json["password"]
        );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "userType":userType,
        "password": password};

}