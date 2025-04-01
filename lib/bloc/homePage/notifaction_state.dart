import 'package:equatable/equatable.dart';
import 'package:go_present/model/notification_list.dart';

class NotificationState extends Equatable {
  final List<NotificationModel> notifications;
  final int unreadCount;

  NotificationState({required this.notifications, required this.unreadCount});

  @override
  List<Object> get props => [notifications, unreadCount];
}
