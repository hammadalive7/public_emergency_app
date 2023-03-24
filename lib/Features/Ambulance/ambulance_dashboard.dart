import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AmbulanceDashboard extends StatefulWidget {
  const AmbulanceDashboard({Key? key}) : super(key: key);

  @override
  State<AmbulanceDashboard> createState() => _AmbulanceDashboardState();
}

class _AmbulanceDashboardState extends State<AmbulanceDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Ambulance Dashboard"),
      ),
    );
  }
}
