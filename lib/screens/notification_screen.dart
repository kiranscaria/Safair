import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safair/screens/loading_screen.dart';
import 'package:safair/services/aqi_helpers.dart';
import 'package:safair/services/aqi_model.dart';
import '../services/notifications_helper.dart';

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoadingScreen()));
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          Text('Basics', textAlign: TextAlign.center),
          RaisedButton(
              child: Text('Notify every minute'),
              onPressed: () async {
                var aqiData = await AQIModel().getLocationAQI();
                var cleanedAQIData = cleanAQIData(aqiData);
                var body = getNotificationBody(cleanedAQIData);

                showPeriodicNotification(
                  notifications,
                  title: 'Safair',
                  body: body,
                  repeatInterval: RepeatInterval.EveryMinute,
                );
              }),
          RaisedButton(
            child: Text('Notify every morning'),
            onPressed: () => showFixedTimeNotification(
              notifications,
              title: 'Safair',
              body: 'Timed: AQI : 160 | Unhealthy | Prominent: pm25',
              time: Time(9, 10, 0),
            ),
          ),
        ],
      ),
    );
  }
}
