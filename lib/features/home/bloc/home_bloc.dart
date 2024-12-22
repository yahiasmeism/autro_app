import 'package:autro_app/features/home/bloc/app_nav_menu_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/failures.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(_mapEvents);
  }

  _mapEvents(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is BlocCreatedEvent) {
      await _init(event, emit);
    }

    if (event is NavigationItemTappedEvent) {
      await _onNavigationItemTap(event, emit);
    }
  }

  _init(BlocCreatedEvent event, Emitter<HomeState> emit) async {
    final navItems = AppMenuItems.appNavItems;
    emit(HomeLoaded(selectedItem: navItems.first, appNavMenuItems: navItems));
  }

  _onNavigationItemTap(NavigationItemTappedEvent event, Emitter<HomeState> emit) {
    final state = this.state as HomeLoaded;

    final index = state.appNavMenuItems.indexOf(event.item);

    final selectedItem = state.appNavMenuItems.elementAt(index);

    emit(state.copyWith(selectedItem: selectedItem));
  }
}
