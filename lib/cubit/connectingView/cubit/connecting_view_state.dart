part of 'connecting_view_cubit.dart';

class ConnectingViewState extends Equatable {
  const ConnectingViewState({
    this.loading = true,
  });

  final bool loading;

  @override
  List<Object> get props => [loading];
}
