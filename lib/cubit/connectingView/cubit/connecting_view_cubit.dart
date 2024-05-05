import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connecting_view_state.dart';

class ConnectingViewCubit extends Cubit<ConnectingViewState> {
  ConnectingViewCubit() : super(const ConnectingViewState());

  void setLoading(bool loading) => emit(ConnectingViewState(loading: loading));
}
