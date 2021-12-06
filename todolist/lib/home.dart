import 'package:flutter/material.dart';
import 'package:todolist/task.dart';
import 'package:todolist/sphelper.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final SPHelper helper = SPHelper();
  List<Task> tasks = [];

  @override
  void initState() {
    helper.init().then((value) => updateScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ToDoList',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        children: getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addTask(context);
        },
        backgroundColor: Colors.purple,
      ),
    );
  }

  Future<dynamic> addTask(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add task'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: txtTitle,
                    decoration: InputDecoration(hintText: 'title'),
                  ),
                  TextField(
                    controller: txtDescription,
                    decoration: InputDecoration(hintText: 'description'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    txtTitle.text = '';
                    txtDescription.text = '';
                  },
                  child: Text('cancel')),
              ElevatedButton(onPressed: saveTask, child: Text('save'))
            ],
          );
        });
  }

  Future saveTask() async {
    int id = helper.getcounter();
    Task task = Task(txtTitle.text, txtDescription.text, id);
    helper.writeTask(task).then((_) {
      updateScreen();
      helper.setcounter();
    });
    txtTitle.text = '';
    txtDescription.text = '';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    tasks.forEach((Task task) {
      tiles.add(Text(
        task.title ?? '',
        style: TextStyle(color: Colors.black),
      ));
    });
    return tiles;
  }

  void updateScreen() {
    tasks = helper.getTasks();
    setState(() {});
  }
}
