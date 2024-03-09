class CamelModel {
  String id;
  String camelNumber;
  String hardWareNumber;
  String age;
  String health;
  String vaccination;
  String price;

  CamelModel({
    required this.id,
    required this.camelNumber,
    required this.hardWareNumber,
    required this.age,
    required this.health,
    required this.vaccination,
    required this.price,
  });

  factory CamelModel.fromJson(Map json) {
    return CamelModel(
      id: json["id"],
      camelNumber: json["camelNumber"],
      hardWareNumber: json["hardWareNumber"],
      age: json["age"],
      health: json["health"],
      vaccination: json["vaccination"],
      price: json["price"],
    );
  }

  Map toJson() => {
        "id": id,
        "camelNumber": camelNumber,
        "hardWareNumber": hardWareNumber,
        "age": age,
        "health": health,
        "vaccination": vaccination,
        "price": price,
      };
}
