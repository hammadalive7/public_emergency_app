import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContactsController extends GetxController {
  static const String _key1 = 'contact1';
  static const String _key2 = 'contact2';
  static const String _key3 = 'contact3';
  static const String _key4 = 'contact4';
  static const String _key5 = 'contact5';

  Future<List<String>> loadData() async {
    var contact1 = '';
    var contact2 = '';
    var contact3 = '';
    var contact4 = '';
    var contact5 = '';
    var prefs = await SharedPreferences.getInstance();
    String? getcontact1 = prefs.getString(_key1);
    String? getcontact2 = prefs.getString(_key2);
    String? getcontact3 = prefs.getString(_key3);
    String? getcontact4 = prefs.getString(_key4);
    String? getcontact5 = prefs.getString(_key5);
    contact1 = getcontact1 ?? '';
    contact2 = getcontact2 ?? '';
    contact3 = getcontact3 ?? '';
    contact4 = getcontact4 ?? '';
    contact5 = getcontact5 ?? '';

    return [contact1, contact2, contact3, contact4, contact5];
    debugPrint("$contact1  $contact2  $contact3  $contact4 $contact5");
  }

  Future<void> setData(String contact1, String contact2, String contact3,
      String contact4, String contact5) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key1, contact1);
    prefs.setString(_key2, contact2);
    prefs.setString(_key3, contact3);
    prefs.setString(_key4, contact4);
    prefs.setString(_key5, contact5);
  }
}
