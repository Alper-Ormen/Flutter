
import 'package:flutter/material.dart';
import 'package:todolist/utils/drawer.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double sayi1 = 0, sayi2 = 0, sonuc = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Sayi Giriniz",
                labelText: "1.Sayı",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                sayi1 = double.parse(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Sayi Giriniz",
                labelText: "2.Sayı",
              ),
              onChanged: (value) {
                sayi2 = double.parse(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Wrap(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sonuc = sayi1 + sayi2;
                      });
                    },
                    child: const Text("+")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sonuc = sayi1 - sayi2;
                      });
                    },
                    child: const Text("-")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sonuc = sayi1 * sayi2;
                      });
                    },
                    child: const Text("*")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sonuc = sayi1 / sayi2;
                      });
                    },
                    child: const Text("/")),
              ],
            ),
          ),
          Expanded(child:Container(alignment: Alignment.center, child: Text("$sonuc",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          ),),
          
          )
        ],
      ),
    );
  }
}

