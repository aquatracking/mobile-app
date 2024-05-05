part of 'aquariums_bloc.dart';

sealed class AquariumsEvent extends Equatable {
  const AquariumsEvent();

  @override
  List<Object> get props => [];
}

final class AquariumsSubscribtionRequested extends AquariumsEvent {
  const AquariumsSubscribtionRequested();
}
