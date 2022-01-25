import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final Function notificationNavigation;

  const NavBar({Key? key, required this.notificationNavigation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Fulano'),
            accountEmail: Text('fulano@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/user.png'),
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/nav_bg.png'),
                )),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notificações'),
            onTap: () => notificationNavigation(context),
          ),
        ],
      ),
    );
  }
}
