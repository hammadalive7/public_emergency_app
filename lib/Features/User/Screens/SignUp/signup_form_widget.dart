import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Controllers/signup_controller.dart';


class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

bool isChecked = false;
bool newsletterSubscription = false;
bool letterChecked = false;

class _SignUpFormWidgetState extends State<SignUpFormWidget> {

  final controller = Get.put(SignUpController());

  // @override
  // void dispose() {
  //   controller.fullName.dispose();
  //   controller.email.dispose();
  //   controller.password.dispose();
  //   controller.phoneNo.dispose();
  //   super.dispose();
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30 - 10),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 2) {
                  return 'Name must be valid';
                }
                // Return null if the entered username is valid
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded),
                labelText: "Full Name",
                hintText: "Full Name",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: controller.email,
              validator: (value) {
                bool _isEmailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!);
                if (!_isEmailValid) {
                  return 'Invalid email.';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: "Email",
                hintText: "Email",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: controller.phoneNo,
              validator: (value) {
                bool _isEmailValid =
                RegExp(r'^(?:[+0][1-9])?[0-9]{8,15}$').hasMatch(value!);
                if (!_isEmailValid) {
                  return 'Invalid phone number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: "Phone Number",
                hintText: "Phone Number",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: controller.password,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 6) {
                  return 'Password must be at least 6 characters in length';
                }
                // Return null if the entered password is valid
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Password",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 30 - 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child:

              //SIGN UP BUTTON THAT WILL SHOW A DIALOG BOX FOR USER  FIRST TO AGREE UPON TERMS AND CONDITIONS, THEN WILL REGISTER

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                                title:
                                Center(child: Text("Terms & Conditions")),
                                insetPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                                titleTextStyle: TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                scrollable: true,
                                content: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  runSpacing: 10,
                                  children: const [
                                    Text(
                                      "User Agreement",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "The Save the Bilby Fund Citizen Science Image identification app is a citizen science project to involve members of the public to categorise field images",
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: 'Roboto'),
                                    ),
                                    Text(
                                      "Acceptance of Terms: By downloading and using this app, you agree to all of the terms and conditions outlined in this agreement. If you do not agree to these terms, you should not use the app.\nPrivacy Policy: Our privacy policy outlines how we collect, use, and protect your personal information when you use our app. By using our app, you agree to our privacy policy.\nUser Conduct: You agree to use the app for lawful purposes only. You agree not to use the app to engage in any conduct that is illegal, harmful, or offensive.\nUser Registration: In order to use certain features of the app, you may need to register and provide certain information. You agree to provide accurate and complete information when registering.\nUser Content: You are solely responsible for any content you upload or transmit through the app. You agree not to upload or transmit any content that is illegal, harmful, or offensive.\nIntellectual Property: The app and all of its content, including but not limited to text, graphics, logos, and images, are the property of the app owners and are protected by copyright and other intellectual property laws.\nDisclaimer of Warranties: The app owners make no warranty that the app will be error-free or uninterrupted. The app owners also make no warranty as to the accuracy or completeness of any content on the app.",
                                      strutStyle: StrutStyle(
                                        fontFamily: 'Roboto',
                                        height: 1.5,
                                      ),
                                      style: TextStyle(fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  Wrap(
                                    runSpacing: 2,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              activeColor: Colors.lightBlueAccent,
                                              checkColor: Colors.white,
                                              value: isChecked,
                                              onChanged: ((bool? value) {
                                                setState(() {
                                                  isChecked = value!;
                                                });
                                              })),
                                          const Text(
                                            'I agree with the Terms and Conditions',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),

                                      Center(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .lightBlueAccent,),


                                            onPressed: (() {
                                                if(isChecked==false){
                                                //USED PACKAGE TO GENERATE THIS TOAST
                                                Get.snackbar("Error", "Please agree to the terms and conditions",
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    duration: Duration(seconds: 3));
                                            }
                                                else{
                                                  Navigator.of(context)
                                                      .pop(AlertDialog);
                                                  if (_formkey.currentState!.validate()) {
                                                    SignUpController.instance.signUp(
                                                      controller.fullName.text.trim(),
                                                      controller.email.text.trim(),
                                                      controller.password.text.trim(),
                                                      controller.phoneNo.text.trim(),
                                                    );

                                                  }

                                                }


                                            }),


                                            child: Text(
                                              "Continue",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),

                                    ],
                                  )
                                ]);
                          },
                        );
                      }));

                },
                child: Text("SignUp".toUpperCase()),
              ),
            ),

          ],
        ),
      ),
    );
  }
}