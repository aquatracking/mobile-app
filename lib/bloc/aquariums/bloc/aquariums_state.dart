part of 'aquariums_bloc.dart';

enum AquariumsStatus { initial, loading, success, failure }

final class AquariumsState extends Equatable {
  const AquariumsState({
    this.status = AquariumsStatus.initial,
    this.aquariums = const <AquariumModel>[],
  });

  final AquariumsStatus status;
  final List<AquariumModel> aquariums;

  AquariumsState copyWith({
    AquariumsStatus Function()? status,
    List<AquariumModel> Function()? aquariums,
  }) {
    return AquariumsState(
      status: status != null ? status() : this.status,
      aquariums: aquariums != null ? aquariums() : this.aquariums,
    );
  }

  @override
  List<Object> get props => [status, aquariums];
}
