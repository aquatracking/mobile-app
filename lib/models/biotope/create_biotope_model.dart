import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_biotope_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CreateBiotopeModel extends Equatable {
  CreateBiotopeModel({
    required this.name,
    required this.description,
    this.startedDate,
    this.volume,
  });

  String name;
  String description;
  DateTime? startedDate;
  double? volume;

  @override
  List<Object?> get props => [
        name,
        description,
        startedDate,
        volume,
      ];

  CreateBiotopeModel copyWith({
    String? name,
    String? description,
    DateTime? startedDate,
    double? volume,
  }) {
    return CreateBiotopeModel(
      name: name ?? this.name,
      description: description ?? this.description,
      startedDate: startedDate ?? this.startedDate,
      volume: volume ?? this.volume,
    );
  }

  static CreateBiotopeModel fromJson(Map<String, dynamic> json) =>
      _$CreateBiotopeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBiotopeModelToJson(this);
}
