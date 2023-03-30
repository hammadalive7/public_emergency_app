import 'dart:io';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Emergency Contacts/emergency_contacts_controller.dart';

class messageController extends GetxController {
  static messageController get instance => Get.find();
  final emergencyContactsController = Get.put(EmergencyContactsController());



  String? _currentAddress;
  Position? _currentPosition;
  void _sendSMS(String message, List<String> recipents) async {

    for (var i = 0; i < recipents.length; i++) {
      String _result = await BackgroundSms.sendMessage(
        //add all phone numbers in phone number list
          phoneNumber: recipents[i].toString(),
          message: message
      ).toString();
      Get.snackbar("SMS", _result);
    }

    print(recipents);

    //     await sendSMS(message: message, recipients: recipents, sendDirect: true)
    //         .catchError((onError) {
    //   print("ERROR IN SENDING FUNCTION!!!" + onError.toString());
    // });
    // print(_result);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String contact1 = prefs.getString('contact1') ?? '';
    String contact2 = prefs.getString('contact2') ?? '';
    String contact3 = prefs.getString('contact3') ?? '';
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
      debugPrint("SMS Permission Granted");
      return true;
    } else {
      debugPrint("SMS Permission Denied");
      return false;
    }
  }

  Future<Position> _getCurrentPosition() async {
    // final hasSmsPermission = handleSmsPermission();

    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
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

  Future<void> sendLocationViaSMS(String EmergencyType) async {
    await _getCurrentPosition().then((_currentAddress) async {
      if (_currentAddress != null) {
        // Get.snackbar("Location", _currentAddress!);
        // final Uri smsLaunchUri = Uri(
        //   scheme: 'sms',
        //   path: '03177674726',
        //   queryParameters: <String, String>{
        //     'body': "HELP me! I am under the water \n http://www.google.com/maps/place/${_currentPosition!.latitude},${_currentPosition!.longitude}"
        //   },
        // );
        // launchUrl(smsLaunchUri);
        // Get.snackbar("Location",
        //     "$_currentPosition.latitude, $_currentPosition.longitude ");
        String message =
            "HELP me! There is an $EmergencyType \n http://www.google.com/maps/place/${_currentPosition!.latitude},${_currentPosition!.longitude}}";
        await emergencyContactsController
            .loadData()
            .then((emergencyContacts) => _sendSMS(message, emergencyContacts));
      } else {}
    });

    // Get.snackbar("Location", "Location not found");
  }
}
