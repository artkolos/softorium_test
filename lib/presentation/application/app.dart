import 'package:flutter/material.dart';
import 'package:softorium_test/presentation/router/app_router.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('ru'),
      routerConfig: _appRouter.config(),
    );
  }
}
