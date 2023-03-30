import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:public_emergency_app/Features/FireFighter/firefighter_dashboard.dart';
import 'package:public_emergency_app/Features/User/Screens/DashBoard/user_dashboard.dart';
import 'package:public_emergency_app/Features/User/Screens/LiveStreaming/live_streaming.dart';
import 'package:public_emergency_app/Features/User/Screens/Profile/profile_screen.dart';
import 'package:public_emergency_app/Features/User/Screens/location_getter_sender.dart';

import '../../../User.dart';
import '../../Ambulance/ambulance_dashboard.dart';
import '../../Police/police_dashboard.dart';
import 'Profile/user_profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 1;
  String userType = "";
  var screens = const [
    ProfileScreen(),
    UserDashboard(),
    LocationPage(),
  ];
  Future<String> getUserType() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var ref =
        FirebaseDatabase.instance.ref().child('Users').child(firebaseUser!.uid);
    final snapshot = await ref.get(); // you should use await on async methods
    if (snapshot!.value != null) {
      var userCurrentInfo = AppUser.fromSnapshot(snapshot);
      setState(() {
        userType = userCurrentInfo.userType;
        debugPrint("User Type: $userType");
      });
      return userCurrentInfo.userType;
    } else {
      return "Error";
    }
  }

  @override
  void initState() {
    super.initState();
    getUserType().then((value) {
      if (userType == "Police") {
        debugPrint("Police");
      } else if (userType == "Ambulance") {
        debugPrint("Ambulance");
      } else if (userType == "Fire") {
        debugPrint("Fire");
      } else if (userType == "User") {
        debugPrint("User");
      } else {
        debugPrint("Error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userType == "Police") {
      screens = const [
        ProfileScreen(),
        PoliceDashboard(),
        UserDashboard(),
      ];
    } else if (userType == "Ambulance") {
      screens = const [
        ProfileScreen(),
        AmbulanceDashboard(),
        UserDashboard(),
      ];
    } else if (userType == "Fire") {
      screens = const [
        ProfileScreen(),
        FirefighterDashboard(),
        UserDashboard(),
      ];
    } else if (userType == "User") {
      screens = const [
        ProfileScreen(),
        UserDashboard(),
        LiveStreamUser(),
      ];
    }
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.white,
          color: Colors.lightBlueAccent,
          animationDuration: const Duration(milliseconds: 300),
          height: 55,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            Icon(
              Icons.person,
              size: 24,
              color: Colors.white,
            ),
            Icon(
              Icons.emergency,
              size: 24,
              color: Colors.white,
            ),
            Icon(
              Icons.video_call,
              size: 24,
              color: Colors.white,
            )
          ]),
      body: screens[currentIndex],
    );
  }
}
