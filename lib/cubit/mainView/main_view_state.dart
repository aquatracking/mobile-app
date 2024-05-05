part of 'main_view_cubit.dart';

enum MainView { home, settings }

final class MainViewState extends Equatable {
  const MainViewState({
    this.view = MainView.home,
  });

  final MainView view;

  @override
  List<Object> get props => [view];
}
