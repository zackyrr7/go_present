abstract class DatePickerEvent {}

class DateSelected extends DatePickerEvent {
  final DateTime selectedDate;
  DateSelected(this.selectedDate);
}
