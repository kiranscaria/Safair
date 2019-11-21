import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safair/services/aqi_helpers.dart';
import 'package:safair/widgets/aqi_meter.dart';
import 'smallinfocard.dart';

class InfoCard extends StatelessWidget {
  final String cityName;
  final int aqiValue;
  final String pollutionLevel;
  final String bigPollutant;
  final int pm2_5Level;
  final double windSpeed;
  final double temperature;
  final Color levelColor;

  InfoCard({
    @required this.cityName,
    @required this.aqiValue,
    @required this.bigPollutant,
    @required this.pollutionLevel,
    @required this.pm2_5Level,
    @required this.temperature,
    @required this.windSpeed,
    @required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Expanded(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        child: Container(
          width: (0.80 * width),
//        height: (0.60 * MediaQuery.of(context).size.height),
//        width: MediaQuery.of(context).size.width - 80,
//        height: MediaQuery.of(context).size.height - 160,
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // aqi meter
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    AQIMeter(
                      aqiValue: aqiValue,
                      width: width,
                      height: height,
                    ),
                    SizedBox(height: 8.0),
                    AutoSizeText(
                      pollutionLevel,
                      textAlign: TextAlign.center,
                      presetFontSizes: [28, 26, 24],
                      style: TextStyle(
                        color: levelColor,
                      ),
                    ),
                    // Prominent Pollutant
                    AutoSizeText(
                      "Prominent: $bigPollutant",
                      textAlign: TextAlign.center,
                      presetFontSizes: [24, 20, 18],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Place / City name
                Flexible(
                  child: AutoSizeText(
                    cityName,
                    presetFontSizes: [24.0, 22.0, 20.0],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 15),
                // Temperature, wind, Pm2.5 cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // PM2.5
                    SmallInfoCard(
                        value: pm2_5Level.toString(),
                        title: "pm2.5",
                        levelColor: levelColor),
                    // temperature
                    SmallInfoCard(
                      value: temperature.toStringAsFixed(1),
                      title: "temp",
                      levelColor: levelColor,
                    ),
                    // wind-speed
                    SmallInfoCard(
                      value: windSpeed.toStringAsFixed(1),
                      title: "wind",
                      levelColor: levelColor,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AutoSizeText(
                  aqiValueToCondition(aqiValue),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  presetFontSizes: [22, 20, 18],
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
