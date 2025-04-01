import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_present/constant.dart';
import 'package:go_present/model/notification_list.dart';
import 'package:go_present/screens/login/login_page.dart';
import 'package:http/http.dart' as http;
import 'notification_event.dart';
import 'notifaction_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final BuildContext context;
  NotificationBloc(this.context)
      : super(NotificationState(notifications: [], unreadCount: 0)) {
    on<FetchNotification>(_fetchNotifications);
    on<MarkAllAsRead>(_markAllAsRead);
  }

  Future<void> _fetchNotifications(
      FetchNotification event, Emitter<NotificationState> emit) async {
    try {
      String? token = await storage.read(key: "token");

      if (token == null) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Loginscreen(),
            ),
          );
        }
      }
      // final token = await SecureStorage.getToken(); // Assuming you have a SecureStorage class to handle secure storage
      final response = await http.get(
        Uri.parse('$url/notifikasi'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('cel');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<NotificationModel> notifications = (data['data'] as List)
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        // Hitung hanya yang isRead == false
        print('dapat notif');
        int unreadCount = notifications.where((notif) => !notif.isRead).length;

        emit(NotificationState(
            notifications: notifications, unreadCount: unreadCount));
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }

  void _markAllAsRead(MarkAllAsRead event, Emitter<NotificationState> emit) {
    List<NotificationModel> updatedNotifications =
        state.notifications.map((notif) {
      return NotificationModel(
        id: notif.id,
        title: notif.title,
        message: notif.message,
        isRead: true, // Semua notifikasi ditandai sebagai sudah dibaca
        createdAt: notif.createdAt,
      );
    }).toList();

    emit(
        NotificationState(notifications: updatedNotifications, unreadCount: 0));
  }
}
