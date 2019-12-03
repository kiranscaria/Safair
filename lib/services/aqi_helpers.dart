import 'dart:core';

import 'package:flutter/material.dart';

Map<String, dynamic> cleanAQIData(dynamic aqiData) {
  Map<String, dynamic> cleanedAQIData = Map();

  if (aqiData.containsKey('data')) {
    // Checks if 'aqi' exists in aqiData['data']
    if (aqiData['data'].containsKey('aqi')) {
      var aqiValue = aqiData['data']['aqi'];
      cleanedAQIData['aqiValue'] = aqiValue;
      cleanedAQIData['levelColor'] = aqiValueToColor(aqiValue);
      cleanedAQIData['pollutionLevel'] = aqiValueToPollutionLevel(aqiValue);
    } else {
      cleanedAQIData['aqiValue'] = 0;
      cleanedAQIData['pollutionLevel'] = "";
      cleanedAQIData['levelColor'] = Colors.white;
    }

    // Checks if 'city' exists in aqiData['data']
    if (aqiData['data'].containsKey('city')) {
      // Checks if 'name' exists in aqiData['data']['city']
      if (aqiData['data']['city'].containsKey('name')) {
        cleanedAQIData['cityName'] = aqiData['data']['city']['name'];
      } else {
        cleanedAQIData['cityName'] = "";
      }

      // Checks if 'url' exists in aqiData['data']['city']
      if (aqiData['data']['city'].containsKey('url')) {
        cleanedAQIData['url'] = aqiData['data']['city']['url'];
      } else {
        cleanedAQIData['url'] = "https://aqicn.org/here";
      }
    }

    // Checks if 'dominentpol' exists in aqiData['data']
    if (aqiData['data'].containsKey('dominentpol')) {
      cleanedAQIData['bigPollutant'] = aqiData['data']['dominentpol'];
    } else {
      cleanedAQIData['bigPollutant'] = "";
    }

    // Checks if 'iaqi' exists in aqiData['data']
    if (aqiData['data'].containsKey('iaqi')) {
      // Checks if 'pm25' exists in aqiData['data']['iaqi']
      if (aqiData['data']['iaqi'].containsKey('pm25')) {
        cleanedAQIData['pm2_5Level'] =
            (aqiData['data']['iaqi']['pm25'].containsKey('v'))
                ? aqiData['data']['iaqi']['pm25']['v'].toString()
                : 0.toString();
      } else {
        cleanedAQIData['pm2_5Level'] = "-";
      }

      // Checks if 'temperature' exists in aqiData['data']['iaqi']
      if (aqiData['data']['iaqi'].containsKey('t')) {
        double temp = (aqiData['data']['iaqi']['t'].containsKey('v'))
            ? aqiData['data']['iaqi']['t']['v'] + 0.0
            : 0.0;
        cleanedAQIData['temperature'] = temp.toStringAsFixed(1);
      } else {
        cleanedAQIData['temperature'] = "-";
      }

      // Checks if 'wind' exists in aqiData['data']['iaqi']
      if (aqiData['data']['iaqi'].containsKey('w')) {
        double wind = (aqiData['data']['iaqi']['w'].containsKey('v'))
            ? aqiData['data']['iaqi']['w']['v'] + 0.0
            : 0.0;
        cleanedAQIData['wind'] = wind.toStringAsFixed(1);
      } else {
        cleanedAQIData['wind'] = "-";
      }
    }
  } else {
    // No key named data
  }
  return cleanedAQIData;
}

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
