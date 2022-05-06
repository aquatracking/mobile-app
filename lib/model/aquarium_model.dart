class AquariumModel {
  String id;
  String name;
  String description;
  String imageUrl;
  bool salt;

  AquariumModel({
    required this.id,
    required this.name,
    this.description = "",
    required this.imageUrl,
    this.salt = false,
  });

  factory AquariumModel.fromJson(Map<String, dynamic> json) => AquariumModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    salt: json["salt"],
  );
}