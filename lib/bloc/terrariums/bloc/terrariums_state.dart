part of 'terrariums_bloc.dart';

enum TerrariumsStatus { initial, loading, success, failure }

final class TerrariumsState extends Equatable {
  const TerrariumsState({
    this.status = TerrariumsStatus.initial,
    this.terrariums = const <TerrariumModel>[],
  });

  final TerrariumsStatus status;
  final List<TerrariumModel> terrariums;

  TerrariumsState copyWith({
    TerrariumsStatus Function()? status,
    List<TerrariumModel> Function()? terrariums,
  }) {
    return TerrariumsState(
      status: status != null ? status() : this.status,
      terrariums: terrariums != null ? terrariums() : this.terrariums,
    );
  }

  @override
  List<Object> get props => [status, terrariums];
}
