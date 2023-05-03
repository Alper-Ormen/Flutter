class Todo {
  int id;
  String Title;
  bool isComplated;
  bool? isstar;

  Todo({required this.id, required this.Title, required this.isComplated, this.isstar = false});
}
