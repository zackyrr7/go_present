import 'package:flutter_bloc/flutter_bloc.dart';
import 'grid_event.dart';
import 'grid_state.dart';

class GridBloc extends Bloc<GridEvent, GridState> {
  GridBloc() : super(GridInitial()) {
    on<GridItemTapped>((event, emit) {
      emit(NavigateToPageState(event.route));
    });
  }
}
