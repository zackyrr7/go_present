abstract class GridState {}

class GridInitial extends GridState {}

class NavigateToPageState extends GridState {
  final String route;
  NavigateToPageState(this.route);
}
