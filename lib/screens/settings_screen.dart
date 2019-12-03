import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:safair/services/aqi_helpers.dart';
import 'package:safair/services/aqi_model.dart';
import 'package:safair/services/notifications_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _isMaskReminderOn = false;
  String _statusNotificationInterval = kDefaultStatusNotificationInterval;

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            // City
            //TODO: Setting to fix the city
            // Location Accuracy
            //TODO: Setting to control the location accuracy
            // Remainders
            SwitchListTile(
              title: Text('Mask reminder', style: TextStyle(fontSize: 18)),
              value: _isMaskReminderOn,
              secondary: Icon(Icons.add_alarm),
              onChanged: (bool value) async {
                // manage preferences
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isMaskReminderOn', value);

                setState(() {
                  _isMaskReminderOn = prefs.getBool('isMaskReminderOn');
                });

                // TODO: Implement the preference Change
              },
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
                        case kEveryMinute:
                          setAQINotificationAtInterval(
                              RepeatInterval.EveryMinute);
                          break;
                        case kHourly:
                          setAQINotificationAtInterval(RepeatInterval.Hourly);
                          break;
                        case kDaily:
                          setAQINotificationAtInterval(RepeatInterval.Daily);
                          break;
                        case kEveryMorning:
                          break;
                        case kLevelChangesToUnhealthy:
                          break;
                      }
                      // TODO: Implement the preference Change
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String getNotificationBody(cleanedAQIData) {
  print(cleanedAQIData["aqiLevel"]);
  String body = "";

  if (cleanedAQIData["aqiValue"] != null)
    body += "AQI: ${cleanedAQIData["aqiValue"]}";
  if (cleanedAQIData["pollutionLevel"] != null)
    body += " | Level : ${cleanedAQIData["pollutionLevel"]}";
  if (cleanedAQIData["cityName"] != null)
    body += " | City: ${cleanedAQIData["cityName"]}";

  return body;
}

void setAQINotificationAtInterval(RepeatInterval interval) async {
  final notifications = FlutterLocalNotificationsPlugin();

  var aqiData = await AQIModel().getLocationAQI();
  var cleanedAQIData = cleanAQIData(aqiData);
  var body = getNotificationBody(cleanedAQIData);

  showPeriodicNotification(
    notifications,
    title: 'Safair',
    body: body,
    repeatInterval: interval,
  );
}
