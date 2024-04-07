import 'package:aquatracking/repository/repository.dart';
import 'package:dio/dio.dart';

class AquariumRepository extends Repository {
  Future<List<dynamic>> getAquariums() async {
    Response<dynamic> response = await Repository.dio.get(
      '/aquariums',
    );

    return response.data;
  }
}
