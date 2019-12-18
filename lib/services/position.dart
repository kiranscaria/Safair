import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  LocationAccuracy preferredAccuracy;

  Location({@required this.preferredAccuracy});

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: preferredAccuracy);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
