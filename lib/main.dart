import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:logger/logger.dart';
import 'package:softorium_test/injection.dart';
import 'package:softorium_test/presentation/application/app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await configureDependencies();
      await initializeDateFormatting();
      runApp(App());
    },
    (err, st) {
      Logger().e(err, stackTrace: st);
    },
  );
}
