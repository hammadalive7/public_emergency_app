import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'emergencies_screen.dart';

class User {
  final String userName;
  final String userType;
  final String currentLat;
  final String currentLong;

  User({
    required this.userName,
    required this.userType,
    required this.currentLat,
    required this.currentLong,
  });
}

class EmergencyMaps extends StatefulWidget {
  final ref = FirebaseDatabase.instance.ref().child('Users');
  List<Marker> responders = [];
  double latitude;
  double longitude;
  EmergencyMaps({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<EmergencyMaps> createState() => _EmergencyMapsState();
}

getResponders() {
  Stream<DatabaseEvent> stream = ref.onValue;
// Subscribe to the stream!
  stream.listen((DatabaseEvent event) {
    print('Event Type: ${event.type}'); // DatabaseEventType.value;
    print('Snapshot: ${event.snapshot}'); // DataSnapshot
    print('Key: ${event.snapshot.key}'); // -M7yGTTEp7O549EzTYtI
  });
}

class _EmergencyMapsState extends State<EmergencyMaps> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponders();
  }

  late Marker userMarker = Marker(
    markerId: const MarkerId("User"),
    position: LatLng(widget.latitude, widget.longitude),
    onTap: () {
      Get.snackbar("User", "User is here");
    },
  );
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(widget.latitude, widget.longitude),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      compassEnabled: true,
      // myLocationEnabled: true,
      // myLocationButtonEnabled: true,
      markers: {userMarker},
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          _controller.complete(controller);
        });
      },
    );
  }
}
