
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ListOfResponders/select_responder.dart';
import '../User/Screens/LiveStreaming/live_stream.dart';

class EmergenciesScreen extends StatefulWidget {
  const EmergenciesScreen({Key? key}) : super(key: key);

  @override
  State<EmergenciesScreen> createState() => _EmergenciesScreenState();
}

final ref = FirebaseDatabase.instance.ref().child('sos');

class _EmergenciesScreenState extends State<EmergenciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      extendBodyBehindAppBar: false,
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
          preferredSize: Size.fromHeight(Get.height * 0.09),
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
                        "Emergencies",
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
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: StreamBuilder(
          stream: ref.onValue,
          builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.hasData) {
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              Map<dynamic, dynamic> map = dataSnapshot.value as dynamic ?? {};
              List<dynamic> list = [];
              list.clear();
              list = map.values.toList();

              return ListView.builder(
                itemCount: snapshot.data!.snapshot.children.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListTile(
                        // onTap: () async{
                        //   var lat= list[index]['lat'];
                        //   var long= list[index]['long'];
                        //   String url = '';
                        //   String urlAppleMaps = '';
                        //   if (Platform.isAndroid) {
                        //     url = 'http://www.google.com/maps/place/$lat,$long';
                        //     if (await canLaunchUrl(Uri.parse(url))) {
                        //       await launchUrl(Uri.parse(url));
                        //     } else {
                        //       throw 'Could not launch $url';
                        //     }
                        //   } else {
                        //     urlAppleMaps = 'https://maps.apple.com/?q=$lat,$long';
                        //     url = 'comgooglemaps://?saddr=&daddr=$lat,$long&directionsmode=driving';
                        //     if (await canLaunchUrl(Uri.parse(url))) {
                        //       await launchUrl(Uri.parse(url));
                        //     } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
                        //       await launchUrl(Uri.parse(urlAppleMaps));
                        //     } else {
                        //       throw 'Could not launch $url';
                        //     }
                        //   }
                        // },
                        onTap: () {
                          var lat = double.parse(list[index]['lat']);
                          var long = double.parse(list[index]['long']);
                          var address = list[index]['address'];
                          var userId = list[index]['videoId'];
                          //ab dekh to
                          Get.to(() => SelectResponder(
                              userLat: lat,
                              userLong: long,
                              userAddress: address,
                              userID: userId));
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
        ),
      ),
    );
  }
}
