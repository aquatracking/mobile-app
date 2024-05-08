import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'biotope_type_state.dart';

class BiotopeTypeCubit extends Cubit<BiotopeTypeState> {
  BiotopeTypeCubit() : super(const BiotopeTypeState());

  void setBiotopeType(BiotopeType biotopeType) =>
      emit(BiotopeTypeState(biotopeType: biotopeType));
}
