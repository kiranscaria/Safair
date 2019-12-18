import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safair/helpers/preference_helpers.dart';
import '../constants.dart';
import '../services/aqi_model.dart';
import 'aqi_model_helpers.dart';
import '../services/notifications.dart';

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

void triggerAQINotificationAtInterval(RepeatInterval interval) async {
  final notification = FlutterLocalNotificationsPlugin();

  // get the preference for location accuracy
  getLocationAccuracyPref().then((result) async {
    var body;

    // check if the stored preference is valid
    for (String acc in kLocationAccuracyList) {
      if (acc == result) {
        LocationAccuracy accuracy = stringToLocationAccuracy(result);
        var aqiData =
            await AQIModel(preferredAccuracy: accuracy).getLocationAQI();
        var cleanedAQIData = cleanAQIData(aqiData);
        body = getNotificationBody(cleanedAQIData);
      }
    }

    showPeriodicNotification(
      notification,
      title: 'Safair',
      body: body,
      repeatInterval: interval,
    );
  });
}

void triggerAQINotificationAtMorning() async {
  final notification = FlutterLocalNotificationsPlugin();
  var time = Time(6, 0, 0);

  // get the preference for location accuracy
  getLocationAccuracyPref().then((result) async {
    var body;

    // check if the stored preference is valid
    for (String acc in kLocationAccuracyList) {
      if (acc == result) {
        LocationAccuracy accuracy = stringToLocationAccuracy(result);
        var aqiData =
            await AQIModel(preferredAccuracy: accuracy).getLocationAQI();
        var cleanedAQIData = cleanAQIData(aqiData);
        body = getNotificationBody(cleanedAQIData);
      }
    }
    showFixedTimeNotification(notification,
        time: time, title: 'Safair', body: body);
  });
}

void triggerAQINotificationAtUnhealthy() async {
  // Get the aqiValue
  var aqiData = await AQIModel().getIPAddressAQI();
  var cleanedAQIData = cleanAQIData(aqiData);
  var aqiValue = cleanedAQIData["aqiValue"];

  // Check if aqi level is unhealthy
  if (aqiValue != null && aqiValue >= 10) {
    final notification = FlutterLocalNotificationsPlugin();
    // Show the notification
    showNotification(notification,
        title: 'Safair', body: getNotificationBody(cleanedAQIData));
  }
}
