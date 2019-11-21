/*
    CODE DERIVED FROM : Flutter-Speedometer (https://github.com/kiranscaria/Flutter-Speedometer)
                by ltdangkhoa
 */
library aqi_radial_meter;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'painter.dart';

class Speedometer extends StatefulWidget {
  Speedometer(
      {Key key,
      this.size = 200,
      this.minValue = 0,
      this.maxValue = 100,
      this.currentValue = 0,
      this.backgroundColor = Colors.white,
      this.meterColor = Colors.lightGreenAccent,
      this.warningColor = Colors.redAccent,
      this.kimColor = Colors.white,
      this.displayNumericStyle,
      this.displayText = '',
      this.displayTextStyle})
      : super(key: key);

  final double size;
  final int minValue;
  final int maxValue;
  final int currentValue;
  final Color backgroundColor;
  final Color meterColor;
  final Color warningColor;
  final Color kimColor;
  final TextStyle displayNumericStyle;
  final String displayText;
  final TextStyle displayTextStyle;

  final Color classColour1 = Color(0xFF00E400);
  final Color classColour2 = Color(0xFFFFFF00);
  final Color classColour3 = Color(0xFFFF7E00);
  final Color classColour4 = Color(0xFFFF0000);
  final Color classColour5 = Color(0xFF8F3F97);
  final Color classColour6 = Color(0xFF7E0023);

  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  @override
  Widget build(BuildContext context) {
    double _size = widget.size;
    int _minValue = widget.minValue;
    int _maxValue = widget.maxValue;
    int _currentValue = widget.currentValue;
    double startAngle = 3.0;
    double endAngle = 21.0;

    double _kimAngle = 0;
    if (_minValue <= _currentValue && _currentValue <= _maxValue) {
      _kimAngle = (((_currentValue - _minValue) * (endAngle - startAngle)) /
              (_maxValue - _minValue)) +
          startAngle;
    } else if (_currentValue < _minValue) {
      _kimAngle = startAngle;
    } else if (_currentValue > _maxValue) {
      _kimAngle = endAngle;
    }

    return Container(
      color: widget.backgroundColor,
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: _size,
            height: _size,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(_size * 0.075),
                  child: Stack(children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        width: _size,
                        height: _size,
                        decoration: new BoxDecoration(
                          color: widget.backgroundColor,
                          boxShadow: [
                            new BoxShadow(
                                color: widget.kimColor,
                                blurRadius: 8.0,
                                spreadRadius: 4.0)
                          ],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: Size(_size, _size),
                      painter: ArcPainter(
                          startAngle: 19.8,
                          sweepAngle: 7.2,
                          color: widget.classColour6),
                    ),
                    CustomPaint(
                      size: Size(_size, _size),
                      painter: ArcPainter(
                          startAngle: 16.2,
                          sweepAngle: 3.6,
                          color: widget.classColour5),
                    ),
                    CustomPaint(
                        size: Size(_size, _size),
                        painter: ArcPainter(
                          startAngle: 14.4,
                          sweepAngle: 1.8,
                          color: widget.classColour4,
                        )),
                    CustomPaint(
                        size: Size(_size, _size),
                        painter: ArcPainter(
                          startAngle: 12.6,
                          sweepAngle: 1.8,
                          color: widget.classColour3,
                        )),
                    CustomPaint(
                        size: Size(_size, _size),
                        painter: ArcPainter(
                          startAngle: 10.8,
                          sweepAngle: 1.8,
                          color: widget.classColour2,
                        )),
                    CustomPaint(
                        size: Size(_size, _size),
                        painter: ArcPainter(
                          startAngle: 9,
                          sweepAngle: 1.8,
                          color: widget.classColour1,
                        )),
                  ]),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      width: _size,
                      height: _size * 0.5,
                      color: widget.backgroundColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: _size * 0.1,
                    height: _size * 0.1,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: widget.kimColor,
                      boxShadow: [
                        new BoxShadow(
                            color: widget.meterColor,
                            blurRadius: 10.0,
                            spreadRadius: 5.0)
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: math.pi / 12 * _kimAngle,
                    child: ClipPath(
                      clipper: KimClipper(),
                      child: Container(
                        width: _size * 0.9,
                        height: _size * 0.9,
                        color: widget.kimColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      widget.displayText,
                      style: widget.displayTextStyle,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, _size * 0.1),
                    child: Text(
                      widget.currentValue.toString(),
                      style: widget.displayNumericStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
