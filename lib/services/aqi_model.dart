import 'package:flutter/material.dart';
import 'package:safair/services/networking.dart';
import 'package:safair/services/position.dart';

class AQIModel {
  final String token = 'c947b31f27ea6ab9b3f05cd0e05a7c44807fe5d7';
  String aqiAPI = 'https://api.waqi.info/feed';

  Future<dynamic> getCityAQI(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$aqiAPI/$cityName/?token=$token');
    var aqiData = await networkHelper.getData();

    return aqiData;
  }

  Future<dynamic> getLocationAQI() async {
    Location location = Location();
    await location.getCurrentLocation();

    String queryUrl =
        '$aqiAPI/geo:${location.latitude};${location.longitude}/?token=$token';
    NetworkHelper networkHelper = NetworkHelper(url: queryUrl);
    var aqiData = await networkHelper.getData();

    return aqiData;
  }
}
