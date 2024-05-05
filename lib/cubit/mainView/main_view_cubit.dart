import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_view_state.dart';

class MainViewCubit extends Cubit<MainViewState> {
  MainViewCubit() : super(const MainViewState());

  void setView(MainView view) => emit(MainViewState(view: view));
  void setViewByIndex(int index) =>
      emit(MainViewState(view: MainView.values[index]));
}
