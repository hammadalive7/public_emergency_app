import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Controllers/session_controller.dart';

import 'live_stream.dart';

class LiveStreamUser extends StatefulWidget {
  const LiveStreamUser({Key? key}) : super(key: key);

  @override
  State<LiveStreamUser> createState() => _LiveStreamUserState();
}

final idController = TextEditingController();
final sessionController = Get.put(SessionController());

class _LiveStreamUserState extends State<LiveStreamUser> {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    //save Current location to database
                    saveCurrentLocation();
                    jumpToLiveStream(
                        context, sessionController.userid.toString(), true);
                  },
                  child: const Text("SOS"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveCurrentLocation() async {
    //save Current location to database
    final ref = FirebaseDatabase.instance.ref("sos/${sessionController.userid.toString()}");
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high).then((value) {
      ref.set({
        "lat": value.latitude.toString(),
        "long": value.longitude.toString(),
        "videoId": sessionController.userid.toString(),
      });
    });



  }
  jumpToLiveStream(BuildContext context, String liveId, bool isHost) {
    if (liveId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveStreamingPage(
            liveId: liveId,
            isHost: isHost,
          ),
        ),
      );
    } else {
      Get.snackbar("Error", "Please enter a valid ID");
    }
  }
}
