import 'package:demo_tdd_clean/features/upcoming/presentation/pages/test_screen.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/pages/upcoming_screen.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getIt.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpcomingScreen(),
      // home: TestScreen(),
    );
  }
}
