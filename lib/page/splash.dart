import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqlite_notes/model/mycolors.dart';
import 'notes_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer _timer;

  @override

  /// initState to change the State and call the await
  void initState() {
    super.initState();
    _navigatetohome();
  }

  /// the awiat method to make the app wait 5 sec and the call _toHome to go home auto
  _navigatetohome() async {
    _timer = Timer(
        const Duration(seconds: 5),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NotesPage())));
  }

  /// _toHome() calls Navigator push to navigate to home page
  _toHome() async {
    _timer.cancel();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NotesPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/Splach.png')),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(primary: Color(MyColors.myColors[0])),
            onPressed: _toHome,
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}
