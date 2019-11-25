import 'dart:async';

import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safair/constants.dart';
import 'package:safair/screens/aqi_screen.dart';
import 'package:safair/services/aqi_model.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  double latitude;
  double longitude;
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        getLocationData();
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void getLocationData() async {
    var aqiData = await AQIModel().getLocationAQI();

    if (aqiData == null) {
      if (!(aqiData['status'] == 'ok')) {
        print('Getting IP based AQI');
        aqiData = await AQIModel().getIPAddressAQI();
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AQIScreen(locationAQI: aqiData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ConnectionStatusBar(),
            Expanded(
              flex: 20,
              child: SpinKitWave(
                color: bgBottomColor,
                size: 80.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
