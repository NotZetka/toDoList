import 'package:flutter/material.dart';
import 'package:todolist/Task.dart';
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
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
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
            content: Column(
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
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    txtTitle.text = '';
                    txtDescription.text = '';
                  },
                  child: Text('cancel')),
              ElevatedButton(onPressed: () {}, child: Text('save'))
            ],
          );
        });
  }

  Future saveTask() async {
    Task task = Task(txtTitle.text, txtDescription.text, 1);
    helper.writeTask(task);
  }

  List<Task> getTasks() {
    return [];
  }
}
