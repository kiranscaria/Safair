import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopBar extends StatelessWidget {
  final textColour = Colors.white;

  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightWidthRatio =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.locationArrow,
                color: textColour, size: 20),
            onPressed: () {},
          ),
          Text(
            'Safair',
            style: TextStyle(
                color: textColour,
                fontSize: 20 * heightWidthRatio,
                fontFamily: 'PlayfairDisplay',
                fontWeight: FontWeight.w200),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.search, color: textColour, size: 20),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
