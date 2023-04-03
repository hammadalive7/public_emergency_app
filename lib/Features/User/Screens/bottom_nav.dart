import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:public_emergency_app/Features/FireFighter/firefighter_dashboard.dart';
import 'package:public_emergency_app/Features/Response%20Screen/emergencies_screen.dart';
import 'package:public_emergency_app/Features/User/Screens/DashBoard/user_dashboard.dart';
import 'package:public_emergency_app/Features/User/Screens/LiveStreaming/sos_page.dart';
import 'package:public_emergency_app/Features/User/Screens/Profile/profile_screen.dart';
import 'package:public_emergency_app/Features/User/Screens/location_getter_sender.dart';
import '../../../User.dart';
import '../../Ambulance/ambulance_dashboard.dart';
import '../../Police/police_dashboard.dart';
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
    LiveStreamUser(),
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // if (userType == "Police") {
    //  setState(() {
    //    screens = const [
    //      ProfileScreen(),
    //      PoliceDashboard(),
    //      EmergenciesScreen(),
    //    ];
    //  });
    // } else if (userType == "Ambulance") {
    //  setState(() {
    //    screens = const [
    //      ProfileScreen(),
    //      AmbulanceDashboard(),
    //      EmergenciesScreen(),
    //    ];
    //  });
    // } else if (userType == "Fire") {
    //   setState(() {
    //     screens = const [
    //       ProfileScreen(),
    //       FirefighterDashboard(),
    //       EmergenciesScreen(),
    //     ];
    //   });
    // } else if (userType == "User") {
    //   setState(() {
    //     screens = const [
    //       ProfileScreen(),
    //       UserDashboard(),
    //       LiveStreamUser(),
    //     ];
    //   });
    // } else {
    //   setState(() {
    //     screens = const [
    //       ProfileScreen(),
    //       UserDashboard(),
    //       LiveStreamUser(),
    //     ];
    //   });
    // }
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
