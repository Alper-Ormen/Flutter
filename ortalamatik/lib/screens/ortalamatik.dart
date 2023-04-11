import 'package:flutter/material.dart';
import 'package:ortalamatik/models/add.dart';

class ortalamatik extends StatefulWidget {
  const ortalamatik({super.key});

  @override
  State<ortalamatik> createState() => _ortalamatikState();
}

List<String> ders = ['1 Kredi', '2 Kredi', '3 Kredi', '4 Kredi'];

class _ortalamatikState extends State<ortalamatik> {
  List<Models> model = [];
  String dersAdi = "";
  final dersadi = TextEditingController();
  final dersnotu = TextEditingController();

  String dropdown = ders.first;
  int _kredi = 0;
  double ortalama = 0;

  void dropdownvalue() {
    setState(() {
      if (dropdown == ders[0]) {
        _kredi = 1;
      }
      if (dropdown == ders[1]) {
        _kredi = 2;
      }
      if (dropdown == ders[2]) {
        _kredi = 3;
      }
      if (dropdown == ders[3]) {
        _kredi = 4;
      }
    });
  }

  void Ortalama() {
    setState(() {
      int dersOrtalamasi = 0;
      int tumDerslerinOrtalamasi = 0;
      int toplamKredi = 0;
      if (model.isNotEmpty) {
        for (var item in model) {
          dersOrtalamasi = item.dersnotu * item.derskredi;
          tumDerslerinOrtalamasi = tumDerslerinOrtalamasi + dersOrtalamasi;
          toplamKredi = toplamKredi + item.derskredi;
        }
        ortalama = tumDerslerinOrtalamasi / toplamKredi;
      } else {
        ortalama = 0;
      }
    });
  }

  void DersEkle() {
    setState(() {
      model.add(Models(
          id: model.isNotEmpty ? model.last.id + 1 : 1,
          baslik: dersadi.text,
          derskredi: _kredi,
          dersnotu: int.parse(dersnotu.text)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ortalamatik"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            dropdownvalue();
            DersEkle();
            Ortalama();
            dersadi.clear();
            dersnotu.clear();
          });
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
            child: TextFormField(
              controller: dersadi,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ders Adi",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.amber),
              )),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "Ortalama: $ortalama",
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.amber),
              )),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.amber),
                            ),
                          ),
                          value: dropdown,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: ders.map((String ders) {
                            return DropdownMenuItem(
                              value: ders,
                              child: Text(ders),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdown = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: TextFormField(
                          controller: dersnotu,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Ders Notu",
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                      child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                    )),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(300, 20, 300, 20),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                itemCount: model.length,
                itemBuilder: (BuildContext context, int index) {
                  Models ders = model[index];
                  return ListTile(
                    tileColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0),
                    ),
                    title: InkWell(
                      child: Text(
                        " ${ders.baslik} Ders Kredi: ${ders.derskredi} Ders Not:${ders.dersnotu}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onLongPress: () {
                      setState(() {
                        model.remove(ders);
                        Ortalama();
                      });
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
