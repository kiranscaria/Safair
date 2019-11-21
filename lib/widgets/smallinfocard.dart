import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SmallInfoCard extends StatelessWidget {
  final String value;
  final String title;
  final Color levelColor;

  SmallInfoCard({
    @required this.value,
    @required this.title,
    @required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: 80,
        decoration: BoxDecoration(
          color: levelColor.withOpacity(0.40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              value,
              textAlign: TextAlign.center,
              presetFontSizes: [20, 24, 28],
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              presetFontSizes: [16, 18, 20],
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
