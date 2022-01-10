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
  List<bool> isSelected = [false, false, false, false, false];
  late int selectedIndex;

  @override
  Widget build(BuildContext context) {
    selectedIndex = widget.profileController.profile.notificationFrequency;
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex == selectedIndex) {
        isSelected[buttonIndex] = true;
      } else {
        isSelected[buttonIndex] = false;
      }
    }
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
              Text('A cada minuto'),
              Text('A cada hora'),
              Text('Diariamente'),
              Text('Semanalmente'),
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
                widget.profileController.profile.notificationFrequency = index;
              });
            },
            isSelected: isSelected,
          ),
          TextButton(
            onPressed: () {
              switch (widget.profileController.profile.notificationFrequency) {
                case 0:
                  NotificationApi.cancelAll();
                  break;
                case 1:
                  NotificationApi.everyMinute();
                  break;
                case 2:
                  NotificationApi.everyHour();
                  break;
                case 3:
                  NotificationApi.everyDay();
                  break;
                case 4:
                  NotificationApi.everyWeek();
                  break;
                default:
                  NotificationApi.cancelAll();
              }
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      )),
    );
  }
}
