import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safair/screens/loading_screen.dart';
import 'package:safair/screens/notification_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //

    // Set portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'FiraSans'),
      title: 'Safair',
      home: LoadingScreen(),
    );
  }
}
