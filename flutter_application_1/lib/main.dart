import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  get elevati => null;
  int _counter = 0;
  double fs = 12;
  void azalt() {
    setState(() {
      fs -=3;
    });
  }

  void arttir() {
    setState(() {
      fs+=3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: InkWell(
          child: const Icon(Icons.add),
          onDoubleTap: () {
            azalt();
          },
          onTap: () {
            arttir();
          },
        ),
        onPressed: () {},
      ),
      drawer: const Drawer(
        child: Icon(Icons.facebook),
      ),
      appBar: AppBar(
        title: const Text(
          "Sayac",
        ),
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _counter += 1;
                });
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                width: 100,
                height: 40,
                child: const Text("+",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            Text("$_counter",
                style: TextStyle(
                    fontSize: fs,
                    color: _counter >= 0 ? Colors.green : Colors.red)),
            InkWell(
                onTap: () {
                  setState(() {
                    _counter -= 1;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  width: 100,
                  height: 40,
                  child: const Text("-",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ))
          ],
        ),
      ),
    );
  }
}
