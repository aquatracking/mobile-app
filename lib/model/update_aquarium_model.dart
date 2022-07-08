import 'dart:typed_data';

class UpdateAquariumModel {
  String name = "";
  String description = "";
  Uint8List? image;

  toJson() {
    return {
      "name": name,
      "description": description,
      "image": image
    };
  }
}