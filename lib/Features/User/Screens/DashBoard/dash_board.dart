import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Screens/DashBoard/grid_dash.dart';

import '../../Controllers/session_controller.dart';
import '../Login/login_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DashBoard'),
      // ),

      appBar: AppBar(
      backgroundColor: Colors.lightBlueAccent,
      centerTitle: true,
      automaticallyImplyLeading: false,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),

      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image(image: AssetImage("assets/logos/emergencyAppLogo.png"), height: 100),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        "DashBoard",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),

                    ],
                  ),
                )
              ],
            ),
          )),
    ),

      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Padding(

          padding: const EdgeInsets.all(18.0),
          child: GridDashboard(),
        ),
      ),

    );

  }
}
