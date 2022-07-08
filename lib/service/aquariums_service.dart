import 'dart:developer';

import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/create_aquarium_model.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/model/update_aquarium_model.dart';
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

  Future<void> updateAquarium(AquariumModel aquariumModel, UpdateAquariumModel updateAquariumModel) async {
    await patch('/aquariums/${aquariumModel.id}', updateAquariumModel.toJson()).catchError((e) {
      log('Error updating aquarium: $e');
      return null;
    });
  }

  Future<List<MeasurementModel>> getMeasurements(AquariumModel aquarium, MeasurementTypeModel measurementType, DateTime from) async {
    var rawMeasurements = await get('/aquariums/${aquarium.id}/measurements/${measurementType.code}?from=${from.toIso8601String()}').catchError((e) {
      log('Error getting measurements: $e');
      return List.empty();
    });

    List<MeasurementModel> measurements = [];

    rawMeasurements.forEach((rawMeasurement) {
      measurements.add(MeasurementModel.fromJson(rawMeasurement));
    });

    return measurements;
  }

  Future<void> addMeasurement(AquariumModel aquarium, MeasurementTypeModel measurementType, String value, DateTime measuredAt) async {
    await post('/aquariums/${aquarium.id}/measurements/${measurementType.code}', {"value" : value, "measuredAt": measuredAt.toIso8601String()}).catchError((e) {
      log('Error adding measurement: $e');
      return null;
    });
  }
}