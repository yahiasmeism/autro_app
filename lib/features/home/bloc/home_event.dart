part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class BlocCreatedEvent extends HomeEvent {}

final class NavigationItemTappedEvent extends HomeEvent {
  final AppNavMenuItem item;

  const NavigationItemTappedEvent({required this.item});

  @override
  List<Object> get props => [item];
}
