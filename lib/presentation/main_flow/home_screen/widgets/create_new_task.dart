import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:softorium_test/domain/bloc/task_bloc/task_bloc.dart';
import 'package:softorium_test/gen/fonts.gen.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final ValueNotifier<bool> _isAddTaskModeNotifier = ValueNotifier(false);
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {
        if (_isAddTaskModeNotifier.value && !_focusNode.hasFocus) {
          context.read<TaskBloc>().add(
                TaskEvent.addTask(
                  title: _textEditingController.text,
                  date: widget.selectedDate,
                ),
              );
          _textEditingController.clear();
          _isAddTaskModeNotifier.value = false;
        }
      },
    );
  }

  @override
  void dispose() {
    _isAddTaskModeNotifier.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () {
        _isAddTaskModeNotifier.value = true;
        _focusNode.requestFocus(null);
      },
      child: ValueListenableBuilder(
        valueListenable: _isAddTaskModeNotifier,
        builder: (context, isAddMode, _) {
          return Container(
            padding: const EdgeInsets.only(
              bottom: 6.0,
              top: 6.0,
              left: 20.0,
            ),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEDEBF9),
                  ),
                ),
                const Gap(20),
                if (isAddMode) ...[
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      focusNode: _focusNode,
                      maxLength: 20,
                      onSubmitted: (value) {
                        _isAddTaskModeNotifier.value = false;
                        context.read<TaskBloc>().add(
                              TaskEvent.addTask(
                                title: _textEditingController.text,
                                date: widget.selectedDate,
                              ),
                            );
                        _textEditingController.clear();
                      },
                    ),
                  ),
                  const Gap(20),
                ] else
                  const Text(
                    'Новая задача',
                    style: TextStyle(
                      fontFamily: FontFamily.nunito,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
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
