part of 'task_bloc.dart';

@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.getTasks({required DateTime date}) = _GetTasks;

  const factory TaskEvent.addTask({
    required String title,
    required DateTime date,
  }) = _AddTask;

  const factory TaskEvent.removeTask({required Task task}) = _RemoveTask;

  const factory TaskEvent.editTask({required Task task}) = _EditTask;
}
