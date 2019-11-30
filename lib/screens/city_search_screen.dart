import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:safair/constants.dart';
import 'package:safair/services/aqi_helpers.dart';
import 'package:safair/services/aqi_model.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [bgTopColor, bgBottomColor],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Safair',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20 *
                              (MediaQuery.of(context).size.height /
                                  MediaQuery.of(context).size.width),
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 9),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 26.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: TextField(
                          autofocus: true,
                          style: TextStyle(color: Colors.black),
                          onChanged: (value) {
                            cityName = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter City Name...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Container(
                          width: 50.0,
                          child: Center(
                            child: Icon(
                              LineAwesomeIcons.search,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          Fluttertoast.showToast(
                            msg: "Searching ...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            textColor: Colors.white,
                            fontSize: 16,
                          );
                          var aqiData = await AQIModel().getCityAQI(cityName);
                          Navigator.pop(context, aqiData);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Spacer()
//              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
