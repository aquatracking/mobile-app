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
}