import 'package:flutter/material.dart';
import 'package:seraj/app/di/service_locator.dart';

import 'app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const App());
}
