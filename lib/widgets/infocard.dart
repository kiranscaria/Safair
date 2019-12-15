import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safair/services/aqi_model_helpers.dart';
import 'package:safair/widgets/aqi_meter.dart';
import 'smallinfocard.dart';

class InfoCard extends StatefulWidget {
  final String cityName;
  final int aqiValue;
  final String pollutionLevel;
  final String bigPollutant;
  final String pm2_5Level;
  final String windSpeed;
  final String temperature;
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
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      lowerBound: 0.0,
      upperBound: 500.0,
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animateAQIMeter();
  }

  @override
  void didUpdateWidget(InfoCard oldWidget) {
    animateAQIMeter();
    super.didUpdateWidget(oldWidget);
  }

  void animateAQIMeter() {
    _controller.value = 0;
    _controller.animateTo(500.0, curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // aqi meter
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return AQIMeter(
                          aqiValue: widget.aqiValue,
                          width: width,
                          height: height,
                        );
                      },
                      child: AQIMeter(
                        aqiValue: widget.aqiValue,
                        width: width,
                        height: height,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    AutoSizeText(
                      widget.pollutionLevel,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      presetFontSizes: [28, 26, 24],
                      style: TextStyle(
                        color: widget.levelColor,
                      ),
                    ),
                    // Prominent Pollutant
                    AutoSizeText(
                      "Prominent: ${widget.bigPollutant}",
                      textAlign: TextAlign.center,
                      presetFontSizes: [18, 16],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Place / City name
                Flexible(
                  child: AutoSizeText(
                    widget.cityName,
                    presetFontSizes: [24.0, 22.0, 20.0],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                // Temperature, wind, Pm2.5 cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // PM2.5
                    SmallInfoCard(
                        value: widget.pm2_5Level,
                        title: "pm2.5",
                        levelColor: widget.levelColor),
                    // temperature
                    SmallInfoCard(
                      value: widget.temperature,
                      title: "temp",
                      levelColor: widget.levelColor,
                    ),
                    // wind-speed
                    SmallInfoCard(
                      value: widget.windSpeed,
                      title: "wind",
                      levelColor: widget.levelColor,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                AutoSizeText(
                  aqiValueToCondition(widget.aqiValue),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  presetFontSizes: [20, 18, 16],
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
