import 'package:flutter/material.dart';

String aqiValueToPollutionLevel(int value) {
  String pollutionLevel;
  if (value >= 0 && value <= 50)
    pollutionLevel = 'Good'; // green
  else if (value > 50 && value <= 100)
    pollutionLevel = 'Moderate'; // yellow
  else if (value > 100 && value <= 150)
    pollutionLevel = 'Unhealthy'; // orange
  else if (value > 150 && value <= 200)
    pollutionLevel = 'Unhealthy'; // red
  else if (value > 200 && value <= 300)
    pollutionLevel = 'Very Unhealthy'; // purple
  else
    pollutionLevel = 'Hazardous'; // maroon

  return pollutionLevel;
}

Color aqiValueToColor(int value) {
  Color color;
  if (value >= 0 && value <= 50)
    color = Color(0xFF00E400); // green
  else if (value > 50 && value <= 100)
    color = Colors.yellow.shade600; // yellow
  else if (value > 100 && value <= 150)
    color = Colors.deepOrange; // orange
  else if (value > 150 && value <= 200)
    color = Color(0xFFFF0000); // red
  else if (value > 200 && value <= 300)
    color = Color(0xFF8F3F97); // purple
  else
    color = Color(0xFF7E0023); // maroon

  return color;
}

String aqiValueToCondition(int value) {
  String condition;

  if (value >= 0 && value <= 50)
    condition = "Air quality is satisfactory."; // green
  else if (value > 50 && value <= 100)
    condition = "Air quality is acceptable."; // yellow
  else if (value > 100 && value <= 150)
    condition =
        "Members of sensitive groups may experience health effects."; // orange
  else if (value > 150 && value <= 200)
    condition = "Everyone may begin to experience health effects."; // red
  else if (value > 200 && value <= 300)
    condition = "Health warnings of emergency conditions."; // purple
  else
    condition =
        "HEALTH ALERT: Everyone may experience more serious health effects"; // maroon

  return condition;
}
