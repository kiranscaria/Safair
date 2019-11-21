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
  int pm2_5Level;
  double temperature;
  double wind;
  Color levelColor;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationAQI);
  }

  void updateUI(dynamic aqiData) {
    setState(() {
      if (aqiData['data'] == null) {
        pollutionLevel = "";
        bigPollutant = "";
        levelColor = Colors.white;
      } else {
        aqiValue = aqiData['data']['aqi'];
        levelColor = aqiValueToColor(aqiValue);
        pollutionLevel = aqiValueToPollutionLevel(aqiValue);
        cityName = (aqiData['data']['city'] != null)
            ? aqiData['data']['city']['name']
            : "";
        if (aqiData['data']['iaqi'] != null) {
          bigPollutant = aqiData['data']['dominentpol'];
          pm2_5Level = (aqiData['data']['iaqi']['pm25'] != null)
              ? aqiData['data']['iaqi']['pm25']['v']
              : 0;
          temperature = (aqiData['data']['iaqi']['t'] != null)
              ? temperature = aqiData['data']['iaqi']['t']['v']
              : 0.0;
          wind = (aqiData['data']['iaqi']['w'] != null)
              ? aqiData['data']['iaqi']['w']['v']
              : 0.0;
        }

        print(aqiData['data']);

        for (int i = 1; i < 100; i++) {}
      }
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
