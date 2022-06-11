import 'package:aquatracking/blocs/abstract_measurements_bloc.dart';
import 'package:aquatracking/model/temperature_measurement_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:rxdart/rxdart.dart';

class TemperatureMeasurementsBloc implements AbstractMeasurementsBloc {
  final _measurementsController = BehaviorSubject<List<TemperatureMeasurementModel>>();
  final AquariumsService _aquariumsService = AquariumsService();

  @override
  fetchMeasurements(String aquariumId, int fetchMode) async {
    DateTime from = DateTime.now();

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

    final measurements = await _aquariumsService.getTemperatureMeasurements(aquariumId, from);
    _measurementsController.add(measurements);
  }

  @override
  Stream<List<TemperatureMeasurementModel>> get stream => _measurementsController.stream;

  get sink => _measurementsController.sink;

  set aquariums(List<TemperatureMeasurementModel> measurements) {
    sink.add(measurements);
  }

  @override
  void dispose() {

  }
}