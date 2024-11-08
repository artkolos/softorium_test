import 'package:softorium_test/domain/models/task/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTaskFromStorage();

  Future<void> addTask(Task newTask);

  Future<void> removeTask(Task task);

  Future<void> editTask(Task task);
}
