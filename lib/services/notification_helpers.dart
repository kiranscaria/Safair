import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'aqi_model.dart';
import 'aqi_model_helpers.dart';
import 'notifications.dart';

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

  var aqiData = await AQIModel().getLocationAQI();
  var cleanedAQIData = cleanAQIData(aqiData);
  var body = getNotificationBody(cleanedAQIData);

  showPeriodicNotification(
    notification,
    title: 'Safair',
    body: body,
    repeatInterval: interval,
  );
}

void triggerAQINotificationAtMorning() async {
  final notification = FlutterLocalNotificationsPlugin();

  var aqiData = await AQIModel().getLocationAQI();
  var cleanedAQIData = cleanAQIData(aqiData);
  var body = getNotificationBody(cleanedAQIData);
  var time = Time(6, 0, 0);

  showFixedTimeNotification(notification,
      time: time, title: 'Safair', body: body);
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
