import 'package:flutter/material.dart';

// background colours
Color bgTopColor = Color(0xFFBC4E9C);
Color bgBottomColor = Color(0xFFF80759);

// Settings - Menu item Title Text Style
const TextStyle kMenuItemStyle = TextStyle(fontSize: 16);

// Preferences
// for AQI Notification Interval
const String kDefaultStatusNotificationInterval = "Every morning";
const String kEveryMinute = "Every minute";
const String kHourly = "Hourly";
const String kDaily = "Daily";
const String kWeekly = "Weekly";
const String kEveryMorning = "Every morning";
const String kLevelChangesToUnhealthy = "Level changes to Unhealthy";
const List<String> kStatusIntervalList = [
  kHourly,
  kEveryMorning,
];
// for Location Accuracy
const String kLow = "Low";
const String kMedium = "Medium";
const String kHigh = "High";
const String kBest = "Best";
const String kDefaultLocationAccuracy = kLow;
const List<String> kLocationAccuracyList = [
  kLow,
  kMedium,
  kHigh,
  kBest,
];
