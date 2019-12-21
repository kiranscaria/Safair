import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safair/constants.dart';
import 'package:safair/helpers/preference_helpers.dart';
import 'package:safair/screens/aqi_screen.dart';
import 'package:safair/services/aqi_model.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  bool _bInternetErrorVisible = true;
  StreamSubscription _subscription;
  AQIModel aqiModel;

  @override
  void initState() {
    super.initState();

    // get the preference for location accuracy
    getLocationAccuracyPref().then((result) {
      // check if the stored preference is valid
      for (String acc in kLocationAccuracyList) {
        if (acc == result) {
          LocationAccuracy accuracy = stringToLocationAccuracy(result);
          setState(() {
            aqiModel = AQIModel(preferredAccuracy: accuracy);
          });
        } else {
          setState(() {
            aqiModel = AQIModel(preferredAccuracy: LocationAccuracy.low);
          });
        }
      }
    });

    // listen for connection changes
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        getLocationData();

        setState(() {
          _bInternetErrorVisible = false;
        });
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'No Connection',
          desc: 'Enable the wifi or mobile connectivity.',
          btnCancelOnPress: () {},
        ).show();
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void getLocationData() async {
    bool gotAQIValue = false;

    // check if the user has set the home city
    String city = await getHomeCityPref();

    print('City : $city');
    var _aqiData = (city != "" && city != null)
        ? await aqiModel.getCityAQI(city)
        : await aqiModel.getLocationAQI();

    if (_aqiData == 'SocketException') {
      _aqiData = "error";

      // TODO: Some error
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        tittle: 'Server Error',
        btnOkText: 'Retry',
        btnOkOnPress: () {
          // TODO: Check if it doesn't result in performance degradation.
          getLocationData();
        },
        desc:
            "Couldn't contact the server. Either the server or your internet is down.",
      ).show();
      // since socket exception

    } else if (_aqiData['status'] != 'ok') {
      // try to get the aqi details based on the ip
      print('Searching for ip based aqi...');
      _aqiData = await aqiModel.getIPAddressAQI();
      print(_aqiData);

      if (_aqiData['status'] == 'ok') {
        gotAQIValue = true;
      }
    } else {
      gotAQIValue = true;
    }
    if (gotAQIValue) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AQIScreen(locationAQI: _aqiData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Visibility(
                key: Key('no-internet-error'),
                visible: _bInternetErrorVisible,
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.redAccent),
                  child: Center(
                    child: Text(
                      'Check your internet connection !!!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: SpinKitWave(color: bgBottomColor, size: 80.0),
              ),
              // To compensate for the top container(no internet)
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
