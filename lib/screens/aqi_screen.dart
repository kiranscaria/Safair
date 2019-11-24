import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:safair/constants.dart';
import 'package:safair/services/aqi_helpers.dart';
import 'package:safair/services/aqi_model.dart';
import 'package:safair/widgets/bottombar.dart';
import 'package:safair/widgets/infocard.dart';
import 'city_search_screen.dart';

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
  int pm2_5Level = 0;
  double temperature = 0.0;
  double wind = 0.0;
  Color levelColor;
  String url;
  AQIModel aqiModel = AQIModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationAQI);
  }

  void updateUI(dynamic aqiData) {
    setState(() {
      if (aqiData.containsKey('data')) {
        // Checks if 'aqi' exists in aqiData['data']
        if (aqiData['data'].containsKey('aqi')) {
          aqiValue = aqiData['data']['aqi'];
          levelColor = aqiValueToColor(aqiValue);
          pollutionLevel = aqiValueToPollutionLevel(aqiValue);
        } else {
          aqiValue = 0;
        }

        // Checks if 'city' exists in aqiData['data']
        if (aqiData['data'].containsKey('city')) {
          // Checks if 'name' exists in aqiData['data']['city']
          if (aqiData['data']['city'].containsKey('name')) {
            cityName = aqiData['data']['city']['name'];
          } else {
            cityName = "";
          }

          // Checks if 'url' exists in aqiData['data']['city']
          if (aqiData['data']['city'].containsKey('url')) {
            url = aqiData['data']['city']['url'];
          } else {
            url = "https://aqicn.org/here";
          }
        }

        // Checks if 'dominentpol' exists in aqiData['data']
        if (aqiData['data'].containsKey('dominentpol')) {
          bigPollutant = aqiData['data']['dominentpol'];
        } else {
          bigPollutant = "";
        }

        // Checks if 'iaqi' exists in aqiData['data']
        if (aqiData['data'].containsKey('iaqi')) {
          // Checks if 'pm25' exists in aqiData['data']['iaqi']
          if (aqiData['data']['iaqi'].containsKey('pm25')) {
            pm2_5Level = (aqiData['data']['iaqi']['pm25'].containsKey('v'))
                ? aqiData['data']['iaqi']['pm25']['v']
                : 0;
          }

          // Checks if 'temperature' exists in aqiData['data']['iaqi']
          if (aqiData['data']['iaqi'].containsKey('t')) {
            temperature = (aqiData['data']['iaqi']['t'].containsKey('v'))
                ? aqiData['data']['iaqi']['t']['v']
                : 0;
          }

          // Checks if 'wind' exists in aqiData['data']['iaqi']
          if (aqiData['data']['iaqi'].containsKey('w')) {
            wind = (aqiData['data']['iaqi']['w'].containsKey('v'))
                ? aqiData['data']['iaqi']['w']['v']
                : 0;
          }
        } else {
          bigPollutant = "";
        }
      }
      // No key named data
      else {
        pollutionLevel = "";
        bigPollutant = "";
        levelColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [bgTopColor, bgBottomColor], // Shifter
//
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              topBar(context),
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
              BottomBar(url: url),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    Color textColour = Colors.white;
    double heightWidthRatio =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon:
                Icon(LineAwesomeIcons.map_marker, color: textColour, size: 30),
            onPressed: () async {
              Fluttertoast.showToast(
                msg: "Getting the AQI...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.greenAccent,
                fontSize: 16,
              );
              var aqiData = await aqiModel.getLocationAQI();

              if (aqiData['status'] != "error") {
                updateUI(aqiData);
              } else {
                Fluttertoast.showToast(
                  msg: "Can't get AQI now",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16,
                );
              }
            },
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
            icon: Icon(LineAwesomeIcons.search, color: textColour, size: 30),
            onPressed: () async {
              var typedNamed = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySearchScreen(),
                ),
              );
              if (typedNamed != null) {
                var aqiData = await aqiModel.getCityAQI(typedNamed);

                if (aqiData['status'] == "ok") {
                  updateUI(aqiData);
                } else {
                  Fluttertoast.showToast(
                    msg: "Can't find the city.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16,
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
