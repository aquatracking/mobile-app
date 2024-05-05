import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/repository/repository.dart';
import 'package:dio/dio.dart';

class AquariumRepository extends Repository {
  Future<List<AquariumModel>> getAquariums() async {
    Response<dynamic> response = await Repository.dio.get(
      '/aquariums',
    );
    List<AquariumModel> aquariums = response.data
        .map<AquariumModel>((data) => AquariumModel.fromJson(data))
        .toList();

    return aquariums;
  }
}
