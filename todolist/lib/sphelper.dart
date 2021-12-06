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
}
