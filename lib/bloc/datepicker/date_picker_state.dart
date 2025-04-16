class DatePickerState {
  final DateTime? selectedDate;

  DatePickerState({this.selectedDate});

  DatePickerState copyWith({DateTime? selectedDate}) {
    return DatePickerState(selectedDate: selectedDate ?? this.selectedDate);
  }
}
