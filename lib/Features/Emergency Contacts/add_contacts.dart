import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'emergency_contacts_controller.dart';

class add_contact extends StatefulWidget {
  const add_contact({Key? key}) : super(key: key);

  @override
  State<add_contact> createState() => _add_contactState();
}

class _add_contactState extends State<add_contact> {

  @override
  void initState() {
    super.initState();
    contactController.loadData();
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

  //Emergency Contacts
  static String _contact1 = '';
  static   String _contact2 = '';
  static   String _contact3 = '';
  static   String _contact4 = '';
  static   String _contact5 = '';

  //Controllers
  final contactController = Get.put(EmergencyContactsController());
  var _formKey = GlobalKey<FormState>();
  var contact1controller = TextEditingController(text: Text(_contact1).data.toString());
  var contact2controller = TextEditingController(text: Text(_contact2).data.toString());
  var contact3controller = TextEditingController(text: Text(_contact3).data.toString());
  var contact4controller = TextEditingController(text: Text(_contact4).data.toString());
  var contact5controller = TextEditingController(text: Text(_contact5).data.toString());

  static const String _key1 = 'contact1';
  static const String _key2 = 'contact2';
  static const String _key3 = 'contact3';
  static const String _key4 = 'contact4';
  static const String _key5 = 'contact5';


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
            preferredSize: Size.fromHeight(100),
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox.fromSize(
                          size: Size(56, 56),
                          child: ClipOval(
                            child: Material(
                              color: Colors.lightBlueAccent,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {  Get.back();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                      ) ,
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add Emergency Contacts here",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              SizedBox(
                width: 300,
                height: 100,
                child: TextFormField(
                  controller: contact1controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'Enter First Contact',
                    labelText: 'Emergency Contact 1',
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 100,
                child: TextFormField(
                  controller: contact2controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'Enter Second Contact',
                    labelText: 'Emergency Contact 2',
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 100,
                child: TextFormField(
                  controller: contact3controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'Enter Second Contact',
                    labelText: 'Emergency Contact 3',
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 100,
                child: TextFormField(
                  controller: contact4controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'Enter Second Contact',
                    labelText: 'Emergency Contact 4',
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 100,
                child: TextFormField(
                  controller: contact5controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    hintText: 'Enter Second Contact',
                    labelText: 'Emergency Contact 5',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        backgroundColor: Colors.blue,
                        // foreground
                      ),
                      child: Text("Save"),
                      onPressed: () async {
                        var contact1 = contact1controller.text.toString();
                        var contact2 = contact2controller.text.toString();
                        var contact3 = contact3controller.text.toString();
                        var contact4 = contact4controller.text.toString();
                        var contact5 = contact5controller.text.toString();

                        contactController.setData(contact1, contact2, contact3, contact4, contact5);
                        contactController.loadData();

                        //toast using Getx
                        Get.snackbar(
                          'Saved', 'Contact Saved Successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                          isDismissible: true,
                          // dismissDirection: SnackDismissDirection.HORIZONTAL,
                          forwardAnimationCurve: Curves.easeOutBack,
                          reverseAnimationCurve: Curves.easeInBack,
                        );
                      }),
                ),
              ),
              // Text(contact1),
            ],
          ),
        ),
      ),
    );
  }

  // void loadData() async {
  //   var contact1 = '';
  //   var contact2 = '';
  //   var contact3 = '';
  //   var contact4 = '';
  //   var contact5 = '';
  //   var prefs = await SharedPreferences.getInstance();
  //   String? getcontact1 = prefs.getString(_key1);
  //   String? getcontact2 = prefs.getString(_key2);
  //   String? getcontact3 = prefs.getString(_key3);
  //   String? getcontact4 = prefs.getString(_key4);
  //   String? getcontact5 = prefs.getString(_key5);
  //   contact1 = getcontact1 ?? '';
  //   contact2 = getcontact2 ?? '';
  //   contact3 = getcontact3 ?? '';
  //   contact4 = getcontact4 ?? '';
  //   contact5 = getcontact5 ?? '';
  //
  //   debugPrint("$contact1  $contact2  $contact3  $contact4 $contact5");
  // }
}
