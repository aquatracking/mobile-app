import 'dart:typed_data';

class CreateAquariumModel {
  String? name;
  String description = "";
  DateTime? startedDate;
  int? volume;
  Uint8List? image;
  bool salt = false;

  toJson() {
    return {
      "name": name,
      "description": description,
      "startedDate": startedDate?.toIso8601String(),
      "volume": volume,
      "image": image,
      "salt": salt
    };
  }
}
