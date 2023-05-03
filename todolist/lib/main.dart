import 'package:flutter/material.dart';
import 'package:todolist/Screens/calculator.dart';
import 'package:todolist/Screens/sayac.dart';
// import 'package:todolist/Screens/ortalamatik';
import 'package:todolist/Screens/todolist.dart';
import 'package:todolist/Screens/todolist_db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: "/",
     routes: {"/": (context) => const mysql(),
     "/todolist":(context) => const Todolist(),
     "/sayac":(context) => const Counter(),
     "/Calculator":(context) => const Calculator(),

     },
      // home: ortalamatik(),
    );
  }
}
