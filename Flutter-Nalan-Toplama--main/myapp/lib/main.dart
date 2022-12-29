import 'package:flutter/material.dart';
import 'package:myapp/screens/nalan.dart';
import 'package:myapp/screens/toplama.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Alper Örmen 673",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.brown),
        home: const Toplama());
  }
}
