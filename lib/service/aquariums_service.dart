import 'dart:developer';

import 'package:aquatracking/model/aquarium_model.dart';
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
}