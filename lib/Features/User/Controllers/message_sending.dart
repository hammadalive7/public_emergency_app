import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class messageController extends GetxController {
  static messageController get instance => Get.find();
  String? _currentAddress;
  Position? _currentPosition;
  void _sendSMS(String message, List<String> recipents) async {
    String _result =
        await sendSMS(message: message, recipients: recipents, sendDirect: true)
            .catchError((onError) {
      print( "ERROR IN SENDING FUNCTION!!!"+ onError.toString());
    });
    print(_result);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Disabled",
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Rejected", 'Location Permissions are denied.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Rejected",
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  handleSmsPermission() async {
    final status = await Permission.sms.request();
    if (status.isGranted) {
      print("SMS Permission Granted");
      return true;
    } else {
      print("SMS Permission Denied");
      return false;
    }
  }



  Future<Position> _getCurrentPosition() async {
    final hasSmsPermission=handleSmsPermission();

    final hasPermission = await _handleLocationPermission();

    if (!hasPermission)
      return Position(
          latitude: 0,
          longitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0);
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
      return _currentPosition!;
    }).catchError((e) {
      debugPrint(e);
    });
    return Position(
        latitude: 0,
        longitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      _currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> sendLocationViaSMS() async {
    await _getCurrentPosition().then((_currentAddress) {
      if (_currentAddress != null) {
        // Get.snackbar("Location", _currentAddress!);
        final Uri smsLaunchUri = Uri(
          scheme: 'sms',
          path: '03177674726',
          queryParameters: <String, String>{
            'body': "HELP me! I am under the water \n http://www.google.com/maps/place/${_currentPosition!.latitude},${_currentPosition!.longitude}"
          },
        );
        // launchUrl(smsLaunchUri);

        Get.snackbar("Location",
            "$_currentPosition.latitude, $_currentPosition.longitude ");
        String message = "HELP me! I am under the water \n http://www.google.com/maps/place/${_currentPosition!.latitude},${_currentPosition!.longitude}}";
        List<String> recipents = ["03177674726", "03236572961"];
        // String message="I am in trouble";
        _sendSMS(message, recipents);
      } else {
        Get.snackbar("Location", "Current Address not found");
      }
    });

    Get.snackbar("Location", "Location not found");
  }
}
