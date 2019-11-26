import 'package:flutter/material.dart';

import '../constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [bgTopColor, bgBottomColor],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Settings'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
