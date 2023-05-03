import 'dart:math';

import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("https://instagram.fteq3-5.fna.fbcdn.net/v/t51.2885-19/342552979_151323994333197_7573354523529642966_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fteq3-5.fna.fbcdn.net&_nc_cat=109&_nc_ohc=VlDKxA7yZCkAX_DXHwC&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfC0qWICpINyr_ENuX81wCNwaTtMlWEbG4zy1ukCfLMH5g&oe=6456359C&_nc_sid=8fd12b")),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Ana Sayfa'),
            onTap: () {
              Navigator.pushNamed(context, "/");
              // Update the state of the app.
              // ...
            },
          ),
        
          ListTile(
            leading: Icon(Icons.dataset_linked_outlined),
            title: const Text('Todolist'),
            onTap: () {
              Navigator.pushNamed(context, "/todolist");

              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.control_point_duplicate_rounded),
            title: const Text('Sayaç'),
            onTap: () {
              Navigator.pushNamed(context, "/sayac");

              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: const Text('Calculator'),
            onTap: () {
              Navigator.pushNamed(context, "/Calculator");

              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
