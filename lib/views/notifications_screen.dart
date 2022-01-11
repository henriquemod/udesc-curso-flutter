import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/api/notifications_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  SharedPreferences sharedPreferences;
  NotificationScreen({Key? key, required this.sharedPreferences})
      : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<bool> isSelected = [false, false, false, false, false];
  late int selectedIndex;

  void _loadNotificationSettings() async {
    try {
      String? value = widget.sharedPreferences.getString("frequency");
      setState(() {
        selectedIndex = (value != null) ? int.parse(value) : 0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Falha ao carregar configurações"),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    selectedIndex = selectedIndex;
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
                selectedIndex = index;
              });
            },
            isSelected: isSelected,
          ),
          TextButton(
            onPressed: () {
              switch (selectedIndex) {
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
              widget.sharedPreferences
                  .setString("frequency", selectedIndex.toString());
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      )),
    );
  }
}
