part of 'biotope_type_cubit.dart';

enum BiotopeType { aquarium, terrarium }

class BiotopeTypeState extends Equatable {
  const BiotopeTypeState({
    this.biotopeType = BiotopeType.aquarium,
  });

  final BiotopeType biotopeType;

  @override
  List<Object> get props => [biotopeType];
}
