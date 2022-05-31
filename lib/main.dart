import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqlite_notes/model/mycolors.dart';
import 'package:sqlite_notes/page/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'MyNotes';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Color(MyColors.myColors[0]),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF1321E0),
            elevation: 0,
          ),
        ),
        home: const Splash(),
      );
}
