import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
              new SettingsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      color: Colors.white.withOpacity(0.80),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            // Remainders
            ListTile(
              leading: Icon(Icons.add_alarm),
              title: Text('Mask remainder', style: TextStyle(fontSize: 18)),
              trailing: ToggleSwitch(
                minWidth: 50.0,
                initialLabelIndex: 0,
                activeBgColor: Colors.redAccent,
                activeTextColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveTextColor: Colors.grey[900],
                labels: ['Off', 'On'],
                onToggle: (index) {
                  print('switched to: $index');
                },
              ),
            ),
            // Notification
            ExpansionTile(
              initiallyExpanded: true,
              leading: Icon(Icons.info),
              title: Text('AQI Status Notification',
                  style: TextStyle(fontSize: 18)),
              children: <Widget>[
                RadioButtonGroup(
                    labelStyle: TextStyle(fontSize: 16),
                    picked: "Every morning",
                    labels: <String>[
                      "Every minute",
                      "Hourly",
                      "Daily",
                      "Weekly",
                      "Every morning",
                      "Level changes to Unhealthy",
                    ],
                    onSelected: (String selected) => print(selected)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
