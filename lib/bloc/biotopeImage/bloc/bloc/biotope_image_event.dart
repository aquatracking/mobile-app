part of 'biotope_image_bloc.dart';

sealed class BiotopeImageEvent extends Equatable {
  const BiotopeImageEvent();

  @override
  List<Object> get props => [];
}

final class BiotopeImageSubscribtionRequested extends BiotopeImageEvent {
  const BiotopeImageSubscribtionRequested();
}
