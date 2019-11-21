import 'package:flutter/material.dart';
import 'package:safair/AQIRadialMeter/aqi_radial_meter.dart';

class AQIMeter extends StatelessWidget {
  final int aqiValue;
  final double width;
  final double height;

  AQIMeter(
      {@required this.aqiValue, @required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Speedometer(
      size: getIdealSize(
        width: width,
        height: height,
      ),
      minValue: 0,
      maxValue: 500,
      currentValue: aqiValue,
      meterColor: Colors.lightBlueAccent,
      warningColor: Colors.orange,
      kimColor: Colors.blueGrey,
      displayNumericStyle: TextStyle(
          fontFamily: 'Digital-Display', color: Colors.black, fontSize: 40),
      displayText: 'AQI',
      displayTextStyle: TextStyle(color: Colors.black, fontSize: 14),
    );
  }

  double getIdealSize({@required double height, @required double width}) {
    return width * ((height - width) / height);
  }
}
