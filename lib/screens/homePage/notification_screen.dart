import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/bloc/homePage/notifaction_state.dart';
import 'package:go_present/bloc/homePage/notification_bloc.dart';
import 'package:go_present/bloc/homePage/notification_event.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        centerTitle: true,
        toolbarHeight: 40,
        actions: [
          IconButton(
              onPressed: () {
                // context.read<NotificationBloc>().add(MarkAllAsRead());
                _showConfirmationDialog(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
        if (state.notifications.isEmpty) {
          return const Center(
            child: Text("Tidak ada notifikasi"),
          );
        }
        return ListView.builder(
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return Container(
                decoration: BoxDecoration(
                    color: notification.isRead
                        ? Colors.white
                        : Colors.blue.shade50,
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300))),
                child: ListTile(
                  leading: Icon(
                    notification.isRead
                        ? Icons.notifications
                        : Icons.notifications_active,
                    color: notification.isRead ? Colors.grey : Colors.red,
                  ),
                  title: Text(
                    notification.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  subtitle: Text(
                    notification.message,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: notification.isRead
                      ? null
                      : const Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 10,
                        ),
                  // onTap: () {
                  //   context.read<NotificationBloc>().add(MarkAllAsRead());
                  // }
                ),
              );
            });
      }),
    );
  }
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text("Konfirmasi"),
          content: const Text("Tandai semua notifilasi sebagai sudah dibaca?"),
          actions: [
            TextButton(
                onPressed: () {
                  context.read<NotificationBloc>().add(MarkAllAsRead());
                  Navigator.of(dialogContext).pop();
                },
                child: Text(
                  'Ya',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text(
                  "Tidak",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color),
                ))
          ],
        );
      });
}
