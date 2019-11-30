import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safair/screens/loading_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          Text('Basics', textAlign: TextAlign.center),
          RaisedButton(
            child: Text('Notify every minute'),
            onPressed: () => showPeriodicNotification(
              notifications,
              title: 'Safair',
              body: 'AQI : 170 | Unhealthy | Prominent: pm25',
              repeatInterval: RepeatInterval.EveryMinute,
            ),
          ),
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
