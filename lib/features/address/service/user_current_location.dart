import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserCurrentLocationService {
  static Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("No location Access");
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    log("lat ${position.latitude} log ${position.longitude}");
    return position;
  }

  static Future<Placemark> getAddressBasedOnPosition(Position pos) async {
    final addresses = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
    );
    Placemark address = addresses.first;
    log(address.toString());
    return address;
  }

  static Future<Placemark> getAddressBasedOnLatLog(
    double lat,
    double log,
  ) async {
    final addresses = await placemarkFromCoordinates(lat, log);
    Placemark address = addresses.first;

    return address;
  }
}
