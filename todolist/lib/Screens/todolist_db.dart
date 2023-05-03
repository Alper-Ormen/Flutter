import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist/Models/Todo.dart';
import 'package:mysql1/mysql1.dart';
import 'package:todolist/utils/drawer.dart';

class mysql extends StatefulWidget {
  const mysql({super.key});

  @override
  State<mysql> createState() => _mysqlState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
late String title;
bool isObscure = true;
List<Todo> mysqltodoList = [];

ConnectionSettings _connectionSettings = ConnectionSettings(
    host: '93.89.225.127',
    port: 3306,
    user: 'ideftp1_testus',
    db: 'ideftp1_testdb',
    password: '123456aA+-');

AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

final myController = TextEditingController();
final TextFormField1 = TextEditingController();
final TextFormField2 = TextEditingController();
final TextFormField3 = TextEditingController();
final TextFormField4 = TextEditingController();
final TextFormField5 = TextEditingController();
final TextFormField6 = TextEditingController();

@override
void dispose() {
  myController.dispose();
}

class _mysqlState extends State<mysql> {
  @override
  void initState() {
    mysqlconn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: addTodo, child: const Icon(Icons.add)),
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('TodoList With Db'),
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              color: Colors.grey,
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: myController,
                  autovalidateMode: autovalidateMode,
                  obscureText: isObscure,
                  maxLines: 1,
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Boş geçilemez!!";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Başlık",
                      hintText: "Başlık giriniz",
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        child: Icon(isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topCenter,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          height: 5,
                          color: Colors.transparent,
                        ),
                    padding: const EdgeInsets.all(5),
                    itemCount: mysqltodoList.length,
                    itemBuilder: (context, index) {
                      Todo item = mysqltodoList[index];
                      return ListTile(
                          tileColor: item.isComplated
                              ? Colors.green[100]
                              : Colors.red[100],
                          subtitle: const Text("Tıkla Ve Tamamla"),
                          leading: Checkbox(
                            activeColor: Colors.green[100],
                            checkColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                item.isComplated = value!;
                                updateIscomplated(item.id, item.isComplated);
                              });
                            },
                            value: item.isComplated,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    deleteTodo(item.id);
                                    mysqltodoList.remove(item);
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    item.isstar = !item.isstar!;
                                    updateIsStar(item.id, !item.isstar!);
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  color: item.isstar!
                                      ? Colors.amber
                                      : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            "${item.id} - ${item.Title}",
                            style: item.isComplated
                                ? const TextStyle(
                                    decoration: TextDecoration.lineThrough)
                                : const TextStyle(),
                          ));
                    }),
              ))
        ],
      ),
    );
  }

  void addTodo() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final conn = await MySqlConnection.connect(_connectionSettings);
      await conn.query(
          'insert into todo (title, iscomplated, isstar) values (?, ?, ?)',
          [title, false, false]);
      var results = await conn.query("select * from todo");
      setState(() {
        mysqltodoList = [];
        for (var element in results) {
          mysqltodoList.add(Todo(
              id: element["id"],
              Title: element["title"],
              isComplated: element["iscomplated"] == 1 ? true : false));
        }
      });

      debugPrint(const mysql().toString());
      formKey.currentState!.reset();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void alertSuccess() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Kapat"))
              ],
              content: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 72,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text("Kayıt Eklendi!")),
                  ],
                ),
              ),
            ));
  }
}

void updateIscomplated(int id, bool iscomplated) async {
  final conn = await MySqlConnection.connect(_connectionSettings);
  conn.query('update todo set iscomplated=? where id =?', [iscomplated, id]);
}

void updateIsStar(int id, bool isstar) async {
  final conn = await MySqlConnection.connect(_connectionSettings);
  conn.query('update todo set isstar=? where id =?', [isstar, id]);
}

void deleteTodo(int id) async {
  final conn = await MySqlConnection.connect(_connectionSettings);
  await conn.query('delete from todo where id = ?', [id]);
}

void mysqlconn() async {
  debugPrint("Bağlanmaya Calıştı");
  final conn = await MySqlConnection.connect(_connectionSettings);
  var results = await conn.query("select * from todo");
  debugPrint(results.toString());
}
