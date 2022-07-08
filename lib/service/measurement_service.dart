import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/service/service.dart';

class MeasurementService extends Service {
  Future<List<MeasurementTypeModel>> getMeasurementTypes() async {
    var rawMeasurementTypes = await get('/measurements/types').catchError((e) {
      return List.empty();
    });

    List<MeasurementTypeModel> measurementTypes = [];

    rawMeasurementTypes.forEach((rawMeasurementType) {
      measurementTypes.add(MeasurementTypeModel.fromJson(rawMeasurementType));
    });

    return measurementTypes;
  }
}