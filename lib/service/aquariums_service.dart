import 'dart:developer';

import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/create_aquarium_model.dart';
import 'package:aquatracking/model/temperature_measurement_model.dart';
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

  Future<List<TemperatureMeasurementModel>> getTemperatureMeasurements(String aquariumId, DateTime from) async {
    var rawMeasurements = await get('/aquariums/$aquariumId/temperature?from=${from.toIso8601String()}').catchError((e) {
      log('Error getting temperature measurements: $e');
      return List.empty();
    });

    List<TemperatureMeasurementModel> measurements = [];

    rawMeasurements.forEach((rawMeasurement) {
      measurements.add(TemperatureMeasurementModel.fromJson(rawMeasurement));
    });

    return measurements;
  }
}