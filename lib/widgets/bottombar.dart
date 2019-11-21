import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:screenshot_share_image/screenshot_share_image.dart';

class BottomBar extends StatelessWidget {
  final iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Container(
              width: 100,
              height: 50,
              child: Icon(FontAwesomeIcons.info, color: iconColor, size: 20),
            ),
            onTap: () {},
          ),
          InkWell(
            child: Container(
              width: 100,
              height: 50,
              child:
                  Icon(FontAwesomeIcons.bullhorn, color: iconColor, size: 20),
            ),
            onTap: () {
              ScreenshotShareImage.takeScreenshotShareImage();
            },
          ),
          InkWell(
            child: Container(
              width: 100,
              height: 50,
              child: Icon(FontAwesomeIcons.cogs, color: iconColor, size: 20),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
