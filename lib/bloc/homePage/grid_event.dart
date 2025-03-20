abstract class GridEvent {}

class GridItemTapped extends GridEvent {
  final String route;

  GridItemTapped({required this.route});
}
