import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirefighterDashboard extends StatefulWidget {
  const FirefighterDashboard({Key? key}) : super(key: key);

  @override
  State<FirefighterDashboard> createState() => _FirefighterDashboardState();
}

class _FirefighterDashboardState extends State<FirefighterDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Firefighter Dashboard"),
      ),
    );
  }
}
