import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/service/measurement_service.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class MeasurementTypesBloc extends Bloc {
  final _measurementTypesController = BehaviorSubject<List<MeasurementTypeModel>>();
  final MeasurementService _measurementService = MeasurementService();

  MeasurementTypesBloc() {
    fetchMeasurementTypes();
  }

  Stream<List<MeasurementTypeModel>> get stream => _measurementTypesController.stream;

  fetchMeasurementTypes() async {
    final measurementTypes = await _measurementService.getMeasurementTypes();
    _measurementTypesController.add(measurementTypes);
  }

  @override
  void dispose() {
    _measurementTypesController.close();
  }
}