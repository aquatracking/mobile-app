import 'dart:developer';
import 'dart:typed_data';

import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/create_aquarium_model.dart';
import 'package:aquatracking/service/service.dart';

class AquariumsService extends Service {

  Future<List<AquariumModel>> getAquariums() async {
    var rawAquariums = await get('/aquariums').catchError((e) {
      log('Error getting aquariums: $e');
      return List.empty();
    });

    List<AquariumModel> aquariums = [];

    rawAquariums.forEach((rawAquarium) {
      aquariums.add(AquariumModel.fromJson(rawAquarium));
    });

    return aquariums;
  }

  Future<void> addAquarium(CreateAquariumModel createAquariumModel) async {
    await post('/aquariums', createAquariumModel.toJson()).catchError((e) {
      log('Error adding aquarium: $e');
      return null;
    });
  }
}