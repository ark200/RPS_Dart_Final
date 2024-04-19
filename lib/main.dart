import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LoginScreen.dart';


void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPS Dart Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _doubleBackToExitPressedOnce = false;
  static const int _doubleBackPressInterval = 2000;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    if (_doubleBackToExitPressedOnce) {
      return true;
    }

    setState(() {
      _doubleBackToExitPressedOnce = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Press Back Again to Exit'),
        duration: Duration(milliseconds: _doubleBackPressInterval),
      ),
    );

    Timer(
      Duration(milliseconds: _doubleBackPressInterval),
          () {
        setState(() {
          _doubleBackToExitPressedOnce = false;
        });
      },
    );

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/rps_logo.png'),
        ),
      ),
    );
  }
}