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
enum UserType { User, Police, FireFighter, Ambulance }
var userType = UserType.User;
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
                prefixIcon: const Icon(Icons.person_outline_rounded),
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
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Password",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Radio<UserType>(value: UserType.User, groupValue: userType, onChanged: (UserType? value) {
                      setState(() { userType = value!; });
                    },),
                    const Text('User'),
                    Radio<UserType>(value: UserType.Police, groupValue: userType, onChanged: (UserType? value) {
                      setState(() { userType = value!; });
                    },),
                    const Text('Police'),
                  ],
                ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Radio<UserType>(value: UserType.FireFighter, groupValue: userType, onChanged: (UserType? value) {
                     setState(() { userType = value!; });
                   },),
                   const Text('Fire Fighter'),
                   Radio<UserType>(value: UserType.Ambulance, groupValue: userType, onChanged: (UserType? value) {
                     setState(() { userType = value!; });
                   },),
                   const Text('Ambulance'),
                 ],
               )
              ],
            ),

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
                                const Center(child: Text("Terms & Conditions")),
                                insetPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                                titleTextStyle: const TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                shape: const RoundedRectangleBorder(
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
                                      "Welcome to Emergency Services. Our app provides a platform for quick response services from police, ambulance, and firefighters in times of emergency.",
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: 'Roboto'),
                                    ),
                                    Text(
                                      "Our app allows you to quickly send out an emergency request with just a few taps, and our responders will be alerted to your location within seconds. As a responder, you can choose your area of expertise and set your availability status. This allows citizens to see which responders are available and respond to emergency requests accordingly. We take your safety seriously. Our app includes a panic button feature, allowing you to quickly alert responders if you're in danger. Additionally, all interactions between responders and citizens are monitored to ensure the highest level of safety. By using our app, you agree to be bound by the following terms and conditions. If you do not agree to these terms and conditions, you may not use our app.",
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
                                                    duration: const Duration(seconds: 3));
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
                                                      userType.toString().split('.').last,
                                                    );

                                                  }

                                                }


                                            }),


                                            child: const Text(
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
                child: Text("Sign Up".toUpperCase()),
              ),
            ),

          ],
        ),
      ),
    );
  }
}