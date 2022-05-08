import 'dart:typed_data';

class AquariumModel {
  String id;
  String name;
  String description;
  DateTime startedDate;
  int volume;
  String imageUrl;
  Uint8List? image;
  bool salt;

  AquariumModel({
    required this.id,
    required this.name,
    this.description = "",
    required this.startedDate,
    required this.volume,
    this.imageUrl = "",
    this.image,
    this.salt = false,
  });

  factory AquariumModel.fromJson(Map<String, dynamic> json) => AquariumModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    startedDate: DateTime.parse(json["startedDate"]),
    volume: json["volume"],
    imageUrl: "",
    image: (json["image"] != null) ? Uint8List.fromList(List<int>.from(json["image"]["data"])) : null,
    salt: json["salt"],
  );
}