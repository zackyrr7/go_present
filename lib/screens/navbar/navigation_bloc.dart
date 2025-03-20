// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';

//EVENTS
abstract class NavigationEvent {}

class selectTab extends NavigationEvent {
  int index;

  selectTab({required this.index});
}

//STATES
class NavigationState {
  final int selectedIndex;

  NavigationState({required this.selectedIndex});
}

//BLOC
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(selectedIndex: 0)) {
    on<selectTab>((event, emit) {
      emit(NavigationState(selectedIndex: event.index));
    });
  }
}
