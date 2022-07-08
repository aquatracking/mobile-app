import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:eventify/eventify.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class MeasurementsBloc extends Bloc {
  final _measurementsController = BehaviorSubject<List<MeasurementModel>>();
  final AquariumsService _aquariumsService = AquariumsService();

  final AquariumModel aquarium;
  final MeasurementTypeModel measurementType;

  int lastFetchMode = 0;

  static final EventEmitter _updateEmitter = EventEmitter();

  MeasurementsBloc({
    required this.aquarium,
    required this.measurementType,
  }) {
    _updateEmitter.on(measurementType.code, MeasurementsBloc, (ev, context) => fetchMeasurements(lastFetchMode));
  }

  static void update(MeasurementTypeModel measurementType) {
    _updateEmitter.emit(measurementType.code);
  }

  fetchMeasurements(int fetchMode) async {
    DateTime from = DateTime.now();
    lastFetchMode = fetchMode;

    switch (fetchMode) {
      case 0:
        from = from.subtract(const Duration(hours: 6));
        break;
      case 1:
        from = from.subtract(const Duration(hours: 24));
        break;
      case 2:
        from = from.subtract(const Duration(days: 7));
        break;
      case 3:
        from = from.subtract(const Duration(days: 30));
        break;
      case 4:
        from = from.subtract(const Duration(days: 365));
        break;
    }

    final measurements = await _aquariumsService.getMeasurements(aquarium, measurementType, from);
    _measurementsController.add(measurements);
  }

  Stream<List<MeasurementModel>> get stream => _measurementsController.stream;

  @override
  void dispose() {
    _measurementsController.close();
  }
}