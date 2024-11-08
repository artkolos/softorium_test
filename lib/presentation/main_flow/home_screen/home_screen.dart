import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:softorium_test/domain/bloc/task_bloc/task_bloc.dart';
import 'package:softorium_test/gen/assets.gen.dart';
import 'package:softorium_test/gen/fonts.gen.dart';
import 'package:softorium_test/injection.dart';
import 'package:softorium_test/presentation/main_flow/home_screen/widgets/date_list.dart';
import 'package:softorium_test/presentation/main_flow/home_screen/widgets/task_holder.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<DateTime> _selectedDateNotifier = ValueNotifier(DateTime.now());

  final _taskBloc = getIt.get<TaskBloc>();

  @override
  void initState() {
    super.initState();
    _taskBloc.add(TaskEvent.getTasks(date: DateTime.now()));
  }

  @override
  void dispose() {
    _taskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => _taskBloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            children: [
              const Gap(36),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Привет, Мир',
                      style: TextStyle(
                        fontFamily: FontFamily.nunito,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Assets.images.avatar.image(),
                  ],
                ),
              ),
              const Gap(37),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  children: [
                    DateList(
                      onTapDate: (value) {
                        _selectedDateNotifier.value = value;
                        _taskBloc.add(TaskEvent.getTasks(date: value));
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _selectedDateNotifier,
                      builder: (context, selectedDate, _) => TaskHolder(
                        selectedDate: selectedDate,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
