import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/api/notifications_api.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificações"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView(
        children: [
          TextButton(
            onPressed: () {
              const delay = 10;
              DateTime currDate = DateTime.now();
              NotificationApi.scheduleNotificationWithBodyText(
                id: 0,
                title: "Localização a $delay atrás",
                body: "Ola mundo",
                payload: "simles.02",
                data: DateTime.now().add(const Duration(seconds: delay)),
              );
            },
            child: const Text("Agendar"),
          ),
        ],
      )),
    );
  }
}
