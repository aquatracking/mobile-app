import 'package:aquatracking/models/terrarium/create_terrarium_model.dart';
import 'package:aquatracking/models/terrarium/terrarium_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';

class TerrariumRepository
    extends BiotopeRepository<TerrariumModel, CreateTerrariumModel> {
  TerrariumRepository()
      : super(
          biotopeType: "terrariums",
          fromJson: TerrariumModel.fromJson,
        );
}
