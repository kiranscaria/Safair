import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safair/constants.dart';
import 'package:safair/screens/settings_screen.dart';
import 'package:screenshot_share_image/screenshot_share_image.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  final url;
  final iconColor = Colors.white;

  BottomBar({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
            color: bgBottomColor.withAlpha(1),
            child: Icon(FontAwesomeIcons.info, color: iconColor, size: 20),
            onPressed: () async {
              Fluttertoast.showToast(
                msg: "Connecting to source...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                fontSize: 16,
              );
              await launch(url, forceWebView: true);
            },
          ),
          FlatButton(
            color: bgBottomColor.withAlpha(1),
            child: Icon(FontAwesomeIcons.shareAlt, color: iconColor, size: 20),
            onPressed: () {
              ScreenshotShareImage.takeScreenshotShareImage();
            },
          ),
          FlatButton(
            color: bgBottomColor.withAlpha(1),
            child: Icon(FontAwesomeIcons.cogs, color: iconColor, size: 20),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
