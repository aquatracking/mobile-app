import 'package:aquatracking/blocs/abstract_measurements_bloc.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:rxdart/rxdart.dart';

class PHMeasurementsBloc implements AbstractMeasurementsBloc {
  final _measurementsController = BehaviorSubject<List<MeasurementModel>>();
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

    final measurements = await _aquariumsService.getPHMeasurements(aquariumId, from);
    _measurementsController.add(measurements);
  }

  @override
  Stream<List<MeasurementModel>> get stream => _measurementsController.stream;

  @override
  void dispose() {
  }
}