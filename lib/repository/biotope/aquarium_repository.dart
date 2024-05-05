import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';

class AquariumRepository extends BiotopeRepository<AquariumModel> {
  AquariumRepository()
      : super(
          biotopeType: "aquariums",
          fromJson: AquariumModel.fromJson,
        );
}
