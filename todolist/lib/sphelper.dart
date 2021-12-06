import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:todolist/task.dart';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeTask(Task task) async {
    prefs.setString(task.id.toString(), json.encode(task.toJson()));
  }

  List<Task> getTasks() {
    List<Task> tasks = [];
    Set<String> keys = prefs.getKeys();
    keys.forEach((String key) {
      if (key != 'counter') {
        Task task = Task.fromJson(jsonDecode(prefs.getString(key) ?? ''));
        tasks.add(task);
      }
    });

    return tasks;
  }

  Future setcounter() async {
    int counter = prefs.getInt('counter') ?? 0;
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getcounter() {
    return prefs.getInt('counter') ?? 0;
  }
}
