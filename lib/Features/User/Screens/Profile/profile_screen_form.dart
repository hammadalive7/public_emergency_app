import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Emergency Contacts/add_contacts.dart';
import '../../Controllers/session_controller.dart';

class ProfileFormWidget extends StatefulWidget {
  ProfileFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String userEmail;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30 - 10),
      // this function will get current user data form firebase
      child: StreamBuilder(
          stream: ref.child(SessionController().userid.toString()).onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

              final nameController =
              TextEditingController(text: map['UserName']);
              final phoneController =
              TextEditingController(text: map['Phone']);
              userEmail=map["email"].toString();
              // debugPrint("USER EMAILLL: ${userEmail}");

              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Info",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30 - 10),
                    TextFormField(
                      controller: nameController,
                      // initialValue: map['UserName'],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be valid';
                        }
                        // Return null if the entered username is valid
                        // return null;
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        labelText: "Full Name",
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30 - 20),
                    TextFormField(
                      // initialValue: map['Phone'],
                      controller: phoneController,

                      validator: (value) {
                        bool _isEmailValid =
                        RegExp(r'^(?:[+0][1-9])?[0-9]{8,15}$')
                            .hasMatch(value!);
                        if (!_isEmailValid) {
                          return 'Invalid phone number';
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Phone Number",
                        hintText: "Phone Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30 - 20),
                    TextFormField(
                      initialValue: map['email'],
                      enableInteractiveSelection: false,
                      focusNode: new AlwaysDisabledFocusNode(),
                      validator: (value) {
                        bool _isEmailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (!_isEmailValid) {
                          return 'Invalid email.';
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: "Email",
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30 - 20),


                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          // ProfileController.instance?.updateprofile(
                          //   nameController.text!.trim(),
                          //   phoneController.text!.trim(),
                          // );





                          if ((_formkey.currentState)!.validate()) {
                            updateprofile(nameController.text!.trim(),
                                phoneController.text!.trim());

                            Get.snackbar("Save", "Profile Updated",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 2));


                          }
                        },
                        child: Text("Update".toUpperCase()),
                      ),
                    ),
                    const SizedBox(height: 30 - 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          Get.to(() => add_contact(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(seconds: 1),
                              arguments: userEmail);
                        },
                        child: Text("Emergency Contacts".toUpperCase()),
                      ),
                    ),

                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  // this function to update user profile
  void updateprofile(String name, String phone) {
    ref.child(SessionController().userid.toString()).update({
      'UserName': name,
      'Phone': phone,
    });
  }
}



class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}