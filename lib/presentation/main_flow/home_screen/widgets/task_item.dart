import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:softorium_test/domain/bloc/task_bloc/task_bloc.dart';
import 'package:softorium_test/domain/models/task/task.dart';
import 'package:softorium_test/gen/fonts.gen.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final ValueNotifier<bool> _isDeleteModeNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _isDeleteModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () => context.read<TaskBloc>().add(TaskEvent.editTask(task: widget.task)),
      onTap: () {
        _isDeleteModeNotifier.value = !_isDeleteModeNotifier.value;
      },
      child: ValueListenableBuilder(
        valueListenable: _isDeleteModeNotifier,
        builder: (context, isDeleteMode, _) {
          return Container(
            padding: const EdgeInsets.only(
              bottom: 6.0,
              top: 6.0,
              left: 20.0,
            ),
            color: isDeleteMode ? const Color(0x33BEB7EB) : null,
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: !widget.task.isActive ? const Color(0xFFCECECE) : const Color(0xFFEDEBF9),
                  ),
                ),
                const Gap(20),
                Text(
                  widget.task.title,
                  style: TextStyle(
                    fontFamily: FontFamily.nunito,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: !widget.task.isActive ? const Color(0xFFCECECE) : null,
                  ),
                ),
                const Spacer(),
                if (isDeleteMode)
                  GestureDetector(
                    onTap: () => context.read<TaskBloc>().add(TaskEvent.removeTask(task: widget.task)),
                    child: const Text(
                      'Удалить',
                      style: TextStyle(
                        fontFamily: FontFamily.nunito,
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
