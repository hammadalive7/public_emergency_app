import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Response Screen/emergencies_screen.dart';


class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({Key? key}) : super(key: key);

  @override
  State<PoliceDashboard> createState() => _PoliceDashboardState();
}

class _PoliceDashboardState extends State<PoliceDashboard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ElevatedButton(onPressed:(){
          Get.to(const EmergenciesScreen());
        }, child: const Text("SOSs")
      ),
    ),
    );
  }
}
