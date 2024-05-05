part of 'terrariums_bloc.dart';

sealed class TerrariumsEvent extends Equatable {
  const TerrariumsEvent();

  @override
  List<Object> get props => [];
}

final class TerrariumsSubscribtionRequested extends TerrariumsEvent {
  const TerrariumsSubscribtionRequested();
}
