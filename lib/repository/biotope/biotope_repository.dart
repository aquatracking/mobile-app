import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/repository/repository.dart';
import 'package:dio/dio.dart';

abstract class BiotopeRepository<T extends BiotopeModel> extends Repository {
  BiotopeRepository({
    required this.biotopeType,
    required this.fromJson,
  });

  final String biotopeType;
  final T Function(Map<String, dynamic>) fromJson;

  Future<List<T>> getList() async {
    Response<dynamic> response = await Repository.dio.get(
      "/$biotopeType",
    );
    List<T> aquariums =
        response.data.map<T>((data) => this.fromJson(data)).toList();

    return aquariums;
  }

  Future<T> create(CreateBiotopeModel biotope) async {
    Response<dynamic> response = await Repository.dio.post(
      "/$biotopeType",
      data: biotope.toJson(),
    );

    return this.fromJson(response.data);
  }
}
