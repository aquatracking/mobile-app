import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class LastMeasurementBloc extends Bloc {
  final _lastMeasurementController = BehaviorSubject<MeasurementModel?>();
  final _aquariumService = AquariumsService();

  final AquariumModel aquarium;
  final MeasurementTypeModel measurementType;

  LastMeasurementBloc({required this.aquarium, required this.measurementType}) {
    fetchLastMeasurement();
  }

  Stream<MeasurementModel?> get stream => _lastMeasurementController.stream;

  fetchLastMeasurement() async {
    final measurement = await _aquariumService.getLastMeasurement(aquarium, measurementType);
    _lastMeasurementController.add(measurement);
  }

  @override
  void dispose() {
    _lastMeasurementController.close();
  }
}