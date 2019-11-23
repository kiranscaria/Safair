import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var aqiData = await AQIModel().getLocationAQI();

    if (!(aqiData['status'] == 'ok')) {
      print('Getting IP based AQI');
      aqiData = await AQIModel().getIPAddressAQI();
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
        child: Container(
          child: SpinKitWave(
            color: Color(0xFFF80759),
            size: 80.0,
          ),
        ),
      ),
    );
  }
}
