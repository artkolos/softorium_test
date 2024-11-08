import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:softorium_test/domain/models/task/task.dart';
import 'package:softorium_test/domain/repository/task_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

part 'task_bloc.freezed.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(this.taskRepository) : super(const TaskState.initial()) {
    on(_onMap);
  }

  final TaskRepository taskRepository;

  FutureOr<void> _onMap(TaskEvent mainEvent, Emitter<TaskState> emit) => mainEvent.map(
        getTasks: (event) => _getTasks(event, emit),
        addTask: (event) => _addTask(event, emit),
        removeTask: (event) => _removeTask(event, emit),
        editTask: (event) => _editTask(event, emit),
      );

  void _getTasks(_GetTasks event, Emitter<TaskState> emit) async {
    final tasks = (await taskRepository.getTaskFromStorage())
        .where(
          (e) => e.date.day == event.date.day && e.date.month == event.date.month,
        )
        .toList();
    emit(TaskState.success(tasks: tasks));
  }

  void _addTask(_AddTask event, Emitter<TaskState> emit) async {
    if (event.title.isEmpty) return;
    final newTask = Task(title: event.title, isActive: true, date: event.date);
    await taskRepository.addTask(newTask);
    add(TaskEvent.getTasks(date: event.date));
  }

  void _editTask(_EditTask event, Emitter<TaskState> emit) async {
    final editTask = Task(title: event.task.title, isActive: !event.task.isActive, date: event.task.date);
    await taskRepository.editTask(editTask);
    add(TaskEvent.getTasks(date: event.task.date));
  }

  void _removeTask(_RemoveTask event, Emitter<TaskState> emit) async {
    await taskRepository.removeTask(event.task);
    add(TaskEvent.getTasks(date: event.task.date));
  }
}
