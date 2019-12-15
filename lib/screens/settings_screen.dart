import 'package:flutter/material.dart';
import 'package:safair/widgets/settings_card.dart';
import '../constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                height: 60,
                child: Center(
                  child: Text(
                    'Safair',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20 *
                            (MediaQuery.of(context).size.height /
                                MediaQuery.of(context).size.width),
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SettingsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
