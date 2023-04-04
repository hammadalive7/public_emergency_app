import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import '../User/Controllers/message_sending.dart';
import '../User/Screens/LiveStreaming/live_stream.dart';

class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({Key? key}) : super(key: key);

  @override
  State<PoliceDashboard> createState() => _PoliceDashboardState();
}

final sosRef = FirebaseDatabase.instance.ref().child('sos');
final activeRespondersRef =
    FirebaseDatabase.instance.ref().child('activeResponders');
final userRef = FirebaseDatabase.instance.ref().child('Users');
String userType = '';
final locationController = Get.put(messageController());
late Position position;
String status = '';

class _PoliceDashboardState extends State<PoliceDashboard> {
  final user = FirebaseAuth.instance.currentUser;
  var Value = false;
  // late Stream<DatabaseEvent> stream = sosRef.child(user!.uid.toString()).onValue;

  @override
  void initState()   {
    super.initState();

  }

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
          preferredSize: Size.fromHeight(Get.height * 0.20),
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
                        height: Get.height * 0.08),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Dashboard",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Set your status: ${status}',
                        style: TextStyle(
                          fontSize: 15.0,
                          backgroundColor: Colors.white,
                          color: setColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SlidingSwitch(
                        value: Value,
                        // initial value of the switch
                        width: 100.0,
                        // width of the switch
                        onChanged: (value) {
                          Value = value;
                          setState(() {
                            status = getStatus();
                          });
                        },
                        height: 40.0,
                        // borderRadius: 20.0,
                        textOff: 'OFF',
                        textOn: 'ON',
                        colorOn: Colors.green,
                        colorOff: Colors.red,
                        onSwipe: () {},
                        onTap: () {},

                        onDoubleTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          child: StreamBuilder(
                  stream: sosRef.onValue,
                  builder: (BuildContext context,
                      AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      Map<dynamic, dynamic> map = dataSnapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();

                      return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ListTile(
                                onTap: () async {
                                  var lat = list[index]['lat'];
                                  var long = list[index]['long'];
                                  String url = '';
                                  String urlAppleMaps = '';
                                  if (Platform.isAndroid) {
                                    url =
                                        'http://www.google.com/maps/place/$lat,$long';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  } else {
                                    urlAppleMaps =
                                        'https://maps.apple.com/?q=$lat,$long';
                                    url =
                                        'comgooglemaps://?saddr=&daddr=$lat,$long&directionsmode=driving';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    } else if (await canLaunchUrl(
                                        Uri.parse(urlAppleMaps))) {
                                      await launchUrl(Uri.parse(urlAppleMaps));
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  }
                                },
                                tileColor: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(
                                  list[index]['address'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  list[index]['time'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.video_call,
                                      color: Colors.red, size: 30),
                                  onPressed: () {
                                    Get.to(
                                      () => LiveStreamingPage(
                                        liveId: list[index]['videoId'],
                                        isHost: false,
                                      ),
                                    );
                                  },
                                )),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
               // Center(
               //    child: Text(
               //      'You are not available to see SOS requests',
               //      style: TextStyle(
               //        fontSize: 20.0,
               //        color: Colors.red,
               //        fontWeight: FontWeight.bold,
               //      ),
               //    ),
               //  )),
      ),
    );
  }

  String getStatus() {
    if (Value == true) {
      // setResponderData();
      setState(() {
        status = 'Available';
        setResponderData();
      });
    } else {
      setState(() {
        status = 'Unavailable';
        activeRespondersRef.child(user!.uid.toString()).remove();
      });
    }
    return status;
  }

  Color setColor() {
    if (Value == true) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }



  setResponderData() async {
    userType='';
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) async {
      try {
        await userRef.child(user!.uid.toString()).get().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            Map<dynamic, dynamic> map = snapshot.value as dynamic;
             userType=map['UserType'];
            activeRespondersRef.child(user!.uid.toString()).set({
              "lat": position.latitude.toString(),
              "long": position.longitude.toString(),
              "responderType": userType,
            });
          } else {
            userType = 'DK BRuh';
          }
        });
      } catch (e) {
        print(e);
      }
    });

  }



  getUserType() async {
    try {
      await userRef.child(user!.uid.toString()).get().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          Map<dynamic, dynamic> map = snapshot.value as dynamic;

          return map['UserType'];
        } else {
          return '';
        }
      });
    } catch (e) {
      print(e);
    }


  }
}
