import 'package:flutter/material.dart';
import 'package:safair/services/aqi_helpers.dart';
import 'package:safair/widgets/bottombar.dart';
import 'package:safair/widgets/infocard.dart';
import 'package:safair/widgets/topbar.dart';

class AQIScreen extends StatefulWidget {
  final locationAQI;

  AQIScreen({@required this.locationAQI});

  @override
  _AQIScreenState createState() => _AQIScreenState();
}

class _AQIScreenState extends State<AQIScreen> {
  String cityName;
  int aqiValue;
  String bigPollutant;
  String pollutionLevel;
  int pm2_5Level = 0;
  double temperature = 0.0;
  double wind = 0.0;
  Color levelColor;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationAQI);
  }

  void updateUI(dynamic aqiData) {
    setState(() {
      if (aqiData.containsKey('data')) {
        // Checks if 'aqi' exists in aqiData['data']
        if (aqiData['data'].containsKey('aqi')) {
          aqiValue = aqiData['data']['aqi'];
          levelColor = aqiValueToColor(aqiValue);
          pollutionLevel = aqiValueToPollutionLevel(aqiValue);
        } else {
          aqiValue = 0;
        }

        // Checks if 'city' exists in aqiData['data']
        if (aqiData['data'].containsKey('city')) {
          cityName = aqiData['data']['city']['name'];
        } else {
          cityName = "";
        }

        // Checks if 'dominentpol' exists in aqiData['data']
        if (aqiData['data'].containsKey('dominentpol')) {
          bigPollutant = aqiData['data']['dominentpol'];
        } else {
          bigPollutant = "";
        }

        // Checks if 'iaqi' exists in aqiData['data']
        if (aqiData['data'].containsKey('iaqi')) {
          // Checks if 'pm25' exists in aqiData['data']['iaqi']
          if (aqiData['iaqi'].containsKey('pm25')) {
            pm2_5Level = (aqiData['data']['iaqi']['pm25'].containsKey('v'))
                ? aqiData['data']['iaqi']['pm25']['v']
                : 0;
          }

          // Checks if 'temperature' exists in aqiData['data']['iaqi']
          if (aqiData['iaqi'].containsKey('temperature')) {
            temperature =
                (aqiData['data']['iaqi']['temperature'].containsKey('v'))
                    ? aqiData['data']['iaqi']['temperature']['v']
                    : 0;
          }

          // Checks if 'wind' exists in aqiData['data']['iaqi']
          if (aqiData['iaqi'].containsKey('wind')) {
            wind = (aqiData['data']['iaqi']['wind'].containsKey('v'))
                ? aqiData['data']['iaqi']['wind']['v']
                : 0;
          }
        } else {
          bigPollutant = "";
        }
      }
      // No key named data
      else {
        pollutionLevel = "";
        bigPollutant = "";
        levelColor = Colors.white;
      }

      print(aqiData['data']);

      for (int i = 1; i < 100; i++) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFBC4E9C), Color(0xFFF80759)], // Shifter
//            colors: [Color(0xFF355c7d), Color(0xFF6c5b7b), Color(0xFFc06c84)], // red Sunset
//            colors: [Color(0xFF4e54c8), Color(0xFF8f94fb)], // Moon Purple
//            colors: [Color(0xFF333333), Color(0xFFDD1818)], // Pure Lust
//            colors: [Color(0xFFA8C0FF), Color(0xFF3F2B96)], // Slight Ocean View
//            colors: [Color(0xFFAD5389), Color(0xFF3C1053)], // expresso
//            colors: [Color(0xFFDA4453), Color(0xFF89216B)], // vanussa
//            colors: [Color(0xFFFDC830), Color(0xFFF37335)], // citrus peel
//            colors: [Color(0xFFA8FF78), Color(0xFF78FFD6)], // summer dog
//            colors: [Color(0xFFED213A), Color(0xFF93291E)],
//            colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
//            colors: [Color(0xFF654EA3), Color(0xFFEAAFC8)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TopBar(),
              InfoCard(
                cityName: cityName,
                aqiValue: aqiValue,
                bigPollutant: bigPollutant,
                pollutionLevel: pollutionLevel,
                pm2_5Level: pm2_5Level,
                temperature: temperature,
                windSpeed: wind,
                levelColor: levelColor,
              ),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
