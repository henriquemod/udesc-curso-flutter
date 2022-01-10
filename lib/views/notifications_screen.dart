import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/api/notifications_api.dart';
import 'package:projeto_modulo_1/controllers/profile_controller.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  ProfileController profileController;
  NotificationScreen({Key? key, required this.profileController})
      : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<bool> isSelected = [true, false, false, false, false, false, false];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.profileController.timers;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificações"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView(
        children: [
          ToggleButtons(
            direction: Axis.vertical,
            children: const <Widget>[
              Text('Desligado'),
              Text('Dias vezes ao dia'),
              Text('Diariamente'),
              Text('Semanalmente'),
              Text('Mensalmente'),
              Text('<Dev> 15 Sec'),
              Text('<Dev> 30 Sec'),
            ],
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
                selectedIndex = index;
              });
            },
            isSelected: isSelected,
          ),
          TextButton(
            onPressed: () {
              int? delay2 = widget.profileController.timers[selectedIndex];
              if (delay2 != null) {
                //DateTime currDate = DateTime.now();
                NotificationApi.scheduleNotificationWithBodyText(
                  id: 0,
                  title: "Localização a $delay2 atrás",
                  body: "Ola mundo",
                  payload: "simles.02",
                  data: DateTime.now().add(Duration(seconds: delay2)),
                );
              }
            },
            child: const Text("Agendar"),
          ),
        ],
      )),
    );
  }
}
