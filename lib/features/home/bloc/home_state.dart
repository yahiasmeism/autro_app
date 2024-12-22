part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoaded extends HomeState {
  final AppNavMenuItem selectedItem;
  final List<AppNavMenuItem> appNavMenuItems;

  int get selectedIndex => appNavMenuItems.indexOf(selectedItem);
  const HomeLoaded({
    required this.selectedItem,
    required this.appNavMenuItems,
  });

  HomeLoaded copyWith({
    AppNavMenuItem? selectedItem,
    List<AppNavMenuItem>? appNavMenuItems,
  }) {
    return HomeLoaded(
      selectedItem: selectedItem ?? this.selectedItem,
      appNavMenuItems: appNavMenuItems ?? this.appNavMenuItems,
    );
  }

  @override
  List<Object?> get props => [selectedItem, appNavMenuItems];
}

final class HomeError extends HomeState {
  final Failure failure;

  const HomeError({required this.failure});

  @override
  List<Object> get props => [failure];
}
