import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:softorium_test/domain/bloc/task_bloc/task_bloc.dart';
import 'package:softorium_test/presentation/main_flow/home_screen/widgets/create_new_task.dart';
import 'package:softorium_test/presentation/main_flow/home_screen/widgets/task_item.dart';

class TaskHolder extends StatelessWidget {
  const TaskHolder({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) => state.map(
              initial: (_) => const SizedBox(),
              success: (success) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(8),
                  Center(
                    child: Text(
                      'План на день ${DateFormat('dd.MM.yyyy').format(selectedDate)}',
                    ),
                  ),
                  const Gap(20),
                  for (var task in success.tasks)
                    TaskItem(
                      task: task,
                    ),
                  CreateNewTask(
                    selectedDate: selectedDate,
                  ),
                  const Gap(14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
