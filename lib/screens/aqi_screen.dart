import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:safair/constants.dart';
import 'package:safair/helpers/aqi_model_helpers.dart';
import 'package:safair/helpers/preference_helpers.dart';
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
  String pm2_5Level;
  String temperature;
  String wind;
  Color levelColor;
  String url;
//  LocationAccuracy
  AQIModel aqiModel;

  @override
  void initState() {
    super.initState();
    var cleanedAQIData = cleanAQIData(widget.locationAQI);
    updateUI(cleanedAQIData);

    // get the preference for location accuracy
    getLocationAccuracyPref().then((result) {
      // check if the stored preference is valid
      for (String acc in kLocationAccuracyList) {
        if (acc == result) {
          LocationAccuracy accuracy = stringToLocationAccuracy(result);
          aqiModel = AQIModel(preferredAccuracy: accuracy);
        }
      }
    });
  }

  void updateUI(dynamic aqiData) {
    setState(() {
      cityName = aqiData["cityName"];
      aqiValue = aqiData["aqiValue"];
      bigPollutant = aqiData["bigPollutant"];
      pollutionLevel = aqiData["pollutionLevel"];
      pm2_5Level = aqiData["pm2_5Level"];
      temperature = aqiData["temperature"];
      wind = aqiData["wind"];
      levelColor = aqiData["levelColor"];
      url = aqiData["url"];
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
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 15.0),
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
                var cleanedData = cleanAQIData(aqiData);
                updateUI(cleanedData);
              } else {
                Fluttertoast.showToast(
                  msg: "Can't get AQI now",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
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
              var aqiData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySearchScreen(),
                ),
              );

              if (aqiData == null) {
              } else if (aqiData == 'SocketException') {
              } else if (aqiData['status'] == "ok") {
                var cleanedData = cleanAQIData(aqiData);
                updateUI(cleanedData);
              } else {
                Fluttertoast.showToast(
                  msg: "Can't find the city.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
