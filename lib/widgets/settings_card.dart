import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:safair/services/notification_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'expansion_tile_no_divider.dart';
import 'keyboard_dismisser.dart';

class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _isMaskReminderOn = false;
  String _statusNotificationInterval = kDefaultStatusNotificationInterval;
  FocusNode cityNameFocusNode;

  @override
  void initState() {
    super.initState();

    // set the mask reminder preference
    getMaskReminderPref().then((result) {
      setState(() {
        _isMaskReminderOn = result;
      });
    });

    // set the Status interval preference
    getStatusNotificationPref().then((result) {
      setState(() {
        _statusNotificationInterval = result;
      });
    });

    // focus node for the city text field
    this.cityNameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    this.cityNameFocusNode.dispose();

    super.dispose();
  }

  Future<bool> getMaskReminderPref() async {
    // obtain shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // get the preference for the mask reminder
    bool remindMask = prefs.getBool('isMaskReminderOn');
    if (remindMask != null)
      return remindMask;
    else
      return false;
  }

  Future<String> getStatusNotificationPref() async {
    // obtain shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // get the preference for the mask reminder
    String notificationInterval = prefs.getString('statusNotificationInterval');
    if (notificationInterval != null)
      return notificationInterval;
    else
      return kDefaultStatusNotificationInterval;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      color: Colors.white.withOpacity(0.90),
      child: KeyboardDismiss(
        context: context,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              // Set the city
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text(
                  'Your city',
                  style: kMenuItemStyle,
                ),
                trailing: new Container(
                  width: 150,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: new TextField(
                          textAlign: TextAlign.end,
                          decoration: InputDecoration.collapsed(
                              hintText: 'Enter your city...'),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),

              // Mask Remainder
              SwitchListTile(
                title: Text('Mask reminder', style: kMenuItemStyle),
                value: _isMaskReminderOn,
                secondary: Icon(Icons.add_alarm),
                onChanged: (bool value) async {
                  // manage preferences
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isMaskReminderOn', value);

                  setState(() {
                    _isMaskReminderOn = prefs.getBool('isMaskReminderOn');
                  });

                  // TODO: Implement the preference Change
                },
              ),

              // Location Accuracy
              ExpansionTileNoDivider(
                initiallyExpanded: true,
                leading: Icon(Icons.location_searching),
                title: Text(
                  'Location Accuracy',
                  style: kMenuItemStyle,
                ),
                children: <Widget>[
                  RadioButtonGroup(
                    labelStyle: kMenuItemStyle,
                    labels: kLocationAccuracyList,
                    onSelected: (String selected) {
                      print(selected);
                    },
                  ),
                ],
              ),

              // Notification Interval
              ExpansionTileNoDivider(
                initiallyExpanded: true,
                leading: Icon(Icons.info),
                title: Text('AQI Notification Interval', style: kMenuItemStyle),
                children: <Widget>[
                  RadioButtonGroup(
                    labelStyle: kMenuItemStyle,
                    picked: _statusNotificationInterval,
                    labels: kStatusIntervalList,
                    onSelected: (String selected) async {
                      // manage preferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                          'statusNotificationInterval', selected);

                      setState(() {
                        _statusNotificationInterval =
                            prefs.getString('statusNotificationInterval');
                      });

                      switch (selected) {
                        case kHourly:
                          triggerAQINotificationAtInterval(
                              RepeatInterval.Hourly);
                          break;
                        case kEveryMorning:
                          triggerAQINotificationAtMorning();
                          break;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
