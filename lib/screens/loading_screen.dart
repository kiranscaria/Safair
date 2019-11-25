import 'dart:async';

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
  bool _bInternetErrorVisible = true;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        getLocationData();
        setState(() {
          _bInternetErrorVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void getLocationData() async {
    var aqiData = await AQIModel().getLocationAQI();

    if (aqiData == null) {
      print('Internet Error');
    } else {
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: SpinKitWave(
                  color: bgBottomColor,
                  size: 80.0,
                ),
              ),
              SizedBox(
                  height:
                      50), // To componsate for the top container(no internet)
            ],
          ),
        ),
      ),
    );
  }
}
