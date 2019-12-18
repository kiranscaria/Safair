import 'package:geolocator/geolocator.dart';
import 'package:safair/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getHomeCityPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _homeCityPref = prefs.getString('homeCityPref');

  return _homeCityPref;
}

Future<String> getLocationAccuracyPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _locationAccuracyPref = prefs.getString('locationAccuracyPref');

  return _locationAccuracyPref;
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
  String notificationInterval =
      prefs.getString('statusNotificationIntervalPref');
  return notificationInterval;
}

LocationAccuracy stringToLocationAccuracy(String value) {
  LocationAccuracy locationAccuracy;

  switch (value) {
    case kLow:
      locationAccuracy = LocationAccuracy.low;
      break;
    case kMedium:
      locationAccuracy = LocationAccuracy.medium;
      break;
    case kHigh:
      locationAccuracy = LocationAccuracy.high;
      break;
    case kBest:
      locationAccuracy = LocationAccuracy.best;
      break;
  }
  return locationAccuracy;
}
