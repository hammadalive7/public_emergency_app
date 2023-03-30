import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  late String _contact1;
  late String _contact2;
  late String _contact3;
  late String _contact4;
  late String _contact5;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _contact1 = prefs.getString('contact1')!;
      _contact2 = prefs.getString('contact2')!;
      _contact3 = prefs.getString('contact3')!;
      _contact4 = prefs.getString('contact4')!;
      _contact5 = prefs.getString('contact5')!;
    });
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
                          "Emergency Contacts",
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
      body: ListView(
      padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(height: 30),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.red.shade200,
            style: ListTileStyle.drawer,
            title: const Text('Contact 1'),
            subtitle: Text(_contact1 ?? ''),
          ),
          const SizedBox(height: 10),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.blueGrey.shade200,
            style: ListTileStyle.drawer,
            title: const Text('Contact 2'),
            subtitle: Text(_contact2 ?? ''),
          ),
          const SizedBox(height: 10),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.red.shade200,
            style: ListTileStyle.drawer,
            title: const Text('Contact 3'),
            subtitle: Text(_contact3?? ''),
          ),
          const SizedBox(height: 10),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.blueGrey.shade200,
            style: ListTileStyle.drawer,
            title: const Text('Contact 4'),
            subtitle: Text(_contact4?? ''),
          ),
          const SizedBox(height: 10),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.red.shade200,
            style: ListTileStyle.drawer,
            title: const Text('Contact 5'),
            subtitle: Text(_contact5?? ''),
          ),
        ],
      ),
    );
  }
}
