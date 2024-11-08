import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softorium_test/domain/models/task/task.dart';

@preResolve
@lazySingleton
class SpSource {
  static const _tasksKey = 'tasks';

  SpSource._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @factoryMethod
  static Future<SpSource> create() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return SpSource._(sharedPreferences);
  }

  List<Task> getTask() {
    final tasksStr = _sharedPreferences.getStringList(_tasksKey);
    final tasks = tasksStr?.map((e) => Task.fromJson(jsonDecode(e))).toList();
    return tasks ?? [];
  }

  Future<void> addTask(Task newTask) async {
    final tasksStr = _sharedPreferences.getStringList(_tasksKey);
    final newTaskStr = jsonEncode(newTask.toJson());
    if (tasksStr != null && tasksStr.isNotEmpty) {
      await _sharedPreferences.setStringList(
        _tasksKey,
        [...tasksStr, newTaskStr],
      );
    } else {
      await _sharedPreferences.setStringList(
        _tasksKey,
        [newTaskStr],
      );
    }
  }

  Future<void> removeTask(Task removeTask) async {
    final tasksStr = _sharedPreferences.getStringList(_tasksKey);
    String removeTaskStr = '';
    if (tasksStr != null && tasksStr.isNotEmpty) {
      for (var taskStr in tasksStr) {
        final task = Task.fromJson(jsonDecode(taskStr));
        if (task.title == removeTask.title && task.date == removeTask.date) {
          Logger().i('remove - $taskStr');
          removeTaskStr = taskStr;
        }
      }
      tasksStr.remove(removeTaskStr);
      await _sharedPreferences.setStringList(_tasksKey, [...tasksStr]);
    }
  }

  Future<void> editTask(Task editTsk) async {
    final tasksStr = _sharedPreferences.getStringList(_tasksKey);
    if (tasksStr != null && tasksStr.isNotEmpty) {
      for (var taskStr in tasksStr) {
        final task = Task.fromJson(jsonDecode(taskStr));
        if (task.title == editTsk.title && task.date == editTsk.date) {
          tasksStr
              .replaceRange(tasksStr.indexOf(taskStr), 1 + tasksStr.indexOf(taskStr), [jsonEncode(editTsk.toJson())]);
        }
      }
      await _sharedPreferences.setStringList(_tasksKey, [...tasksStr]);
    }
  }
}
