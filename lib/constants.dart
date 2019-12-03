import 'package:flutter/material.dart';

// background colours
Color bgTopColor = Color(0xFFBC4E9C);
Color bgBottomColor = Color(0xFFF80759);

// Preferences
const String kDefaultStatusNotificationInterval = "Every morning";
const String kEveryMinute = "Every minute";
const String kHourly = "Hourly";
const String kDaily = "Daily";
const String kWeekly = "Weekly";
const String kEveryMorning = "Every morning";
const String kLevelChangesToUnhealthy = "Level changes to Unhealthy";
const List<String> kStatusIntervalList = [
  kEveryMinute,
  kHourly,
  kDaily,
  kEveryMorning,
  kLevelChangesToUnhealthy,
];
