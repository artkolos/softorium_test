import 'package:injectable/injectable.dart';
import 'package:softorium_test/data/source/sp_source.dart';
import 'package:softorium_test/domain/models/task/task.dart';
import 'package:softorium_test/domain/repository/task_repository.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl extends TaskRepository {
  TaskRepositoryImpl(this.spSource);

  final SpSource spSource;

  @override
  Future<void> addTask(Task newTask) async => await spSource.addTask(newTask);

  @override
  Future<void> editTask(Task task) async => await spSource.editTask(task);

  @override
  Future<List<Task>> getTaskFromStorage() async => spSource.getTask();

  @override
  Future<void> removeTask(Task task) async => await spSource.removeTask(task);
}
