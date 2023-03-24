import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoliceOptions extends StatelessWidget {
  const PoliceOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            preferredSize: Size.fromHeight(Get.height * 0.1),
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: const AssetImage(
                              "assets/logos/emergencyAppLogo.png"),
                          height: Get.height * 0.1),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Police Options",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                 tileColor: Colors.blue.shade300,
                leading: const Icon(Icons.map),
                title: const Text('Police Station Map Display'),
                subtitle: const Text('Find the nearest police station on the map'),
                // trailing: Icon(Icons.police),
                onTap: () {
                  // Add code here to display the nearest police station on the map
                },
              ),
            ),
            Card(
              child: ListTile(
                tileColor: Colors.blue.shade600,
                leading: const Icon(Icons.call),
                title: const Text('Call'),
                subtitle: const Text('Directly call the police station helpline'),
                // onTap: () => ('tel:100'),
              ),
            ),
            Card(
              child: ListTile(
                tileColor: const Color(0xfff85757),
                leading: const Icon(Icons.message),
                title: const Text('Send Distress Message'),
                subtitle: const Text('Send a distress message to emergency contacts'),
                onTap: () {
                  // Add code here to send a distress message to emergency contacts
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
