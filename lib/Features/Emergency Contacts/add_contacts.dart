import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class add_contact extends StatefulWidget {
  const add_contact({Key? key}) : super(key: key);

  @override
  State<add_contact> createState() => _add_contactState();
}

class _add_contactState extends State<add_contact> {

  var _formKey = GlobalKey<FormState>();
  var contact1controller = TextEditingController();
  var contact2controller = TextEditingController();

  static const String _key1 = 'contact1';
  static const String _key2 = 'contact2';
  var contact1 = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contact'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 100,
              child: TextFormField(
                controller: contact1controller,

                decoration: const InputDecoration(

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  hintText: 'Enter First Contact',
                  labelText: 'Contact 1',
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
                      Radius.circular(20.0),
                    ),
                  ),
                  hintText: 'Enter Second Contact',
                  labelText: 'Contact 2',
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
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      backgroundColor: Colors.blue,
                      // foreground
                    ),

                      child: Text("Save"),
                      onPressed: () async {
                        var contact1 = contact1controller.text.toString();
                        var contact2 = contact2controller.text.toString();

                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString(_key1, contact1);
                        prefs.setString(_key2, contact2);

                        //toast using Getx
                       Get.snackbar('Saved', 'Contact Saved Successfully',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                            isDismissible: true,
                            // dismissDirection: SnackDismissDirection.HORIZONTAL,
                            forwardAnimationCurve: Curves.easeOutBack,
                            reverseAnimationCurve: Curves.easeInBack,
                            );

                      }

              ),
            ),
            ),
            Text(contact1),
          ],
        ),
      ),
    );
  }
  void loadData() async {

    var prefs = await SharedPreferences.getInstance();
    var getcontact1 = prefs.getString(_key1);
    contact1 = getcontact1 != null ? getcontact1 : 'no contact';

  }

}

