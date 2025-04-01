import 'package:equatable/equatable.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotification extends NotificationEvent {}

class MarkAllAsRead extends NotificationEvent {}
