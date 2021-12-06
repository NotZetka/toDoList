import 'package:flutter/material.dart';
import 'package:todolist/task.dart';
import 'package:todolist/sphelper.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List<Task> tasks = [];
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
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
                  )
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
                child: Text('Cancel'),
              ),
              ElevatedButton(onPressed: saveTask, child: Text('Save'))
            ],
          );
        });
  }

  Future saveTask() async {
    int id = helper.getCounter() + 1;
    Task newTask = Task(id, txtTitle.text, txtDescription.text);
    helper.writeTask(newTask).then((_) {
      updateScreen();
      helper.setCounter();
    });
    txtDescription.text = '';
    txtTitle.text = '';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    tasks.forEach((task) {
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          helper.deleteSession(task.id).then((value) => updateScreen());
        },
        child: ListTile(
          title: Text(task.title ?? ''),
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(task.description),
                  );
                });
          },
          hoverColor: Colors.grey[200],
        ),
      ));
    });
    return tiles;
  }

  void updateScreen() {
    tasks = helper.getTasks();
    setState(() {});
  }
}
