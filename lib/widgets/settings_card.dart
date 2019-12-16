import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:safair/helpers/notification_helpers.dart';
import 'package:safair/helpers/preference_helpers.dart';
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
  String _statusNotificationIntervalPref = kDefaultStatusNotificationInterval;
  String _locationAccuracyPref = 'Default';
  String _homeCityPref = 'Enter your city...';
  FocusNode cityNameFocusNode;

  @override
  void initState() {
    super.initState();

    // get the mask reminder preference
    getMaskReminderPref().then((result) {
      setState(() {
        _isMaskReminderOn = result;
      });
    });

    // get the Status interval preference
    getStatusNotificationPref().then((result) {
      setState(() {
        _statusNotificationIntervalPref = result;
      });
    });

    // get the Home city preference
    getHomeCityPref().then((result) {
      if (result != '') {
        setState(() {
          _homeCityPref = result;
        });
      }
    });

    //get the location accuracy preference
    getLocationAccuracyPref().then((result) {
      setState(() {
        _locationAccuracyPref = result;
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
            physics: NeverScrollableScrollPhysics(),
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
                        flex: 5,
                        child: new TextField(
                          textAlign: TextAlign.end,
                          decoration: InputDecoration.collapsed(
                              hintText: _homeCityPref),
                          onChanged: (cityName) async {
                            // TODO: check if the city is in the list of cities

                            // set the value of the preferred city
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString("homeCityPref", cityName);

                            // TODO: Implement the preference change: City
                          },
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

                  // TODO: Implement the preference change: Mask remainder
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
                    picked: _locationAccuracyPref,
                    onSelected: (String selected) async {
                      // set the location accuracy preferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString("locationAccuracyPref", selected);
                      print(selected);

                      // TODO: Implement the preference change: Location accuracy
                      setState(() {
                        _locationAccuracyPref =
                            prefs.getString('locationAccuracyPref');
                      });
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
                    picked: _statusNotificationIntervalPref,
                    labels: kStatusIntervalList,
                    onSelected: (String selected) async {
                      // manage preferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                          'statusNotificationIntervalPref', selected);

                      setState(() {
                        _statusNotificationIntervalPref =
                            prefs.getString('statusNotificationIntervalPref');
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
