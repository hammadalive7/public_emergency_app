



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Controllers/session_controller.dart';

import '../Screens/SignUp/verify_email_page.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();


  // TextField Controllers to get data from TextFields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  // TextField Validation

  //Call this Function from Design & it will do the rest
  void loginUser(String email, String password) async {

    FirebaseAuth auth = FirebaseAuth.instance;


    // user authentication
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        SessionController().userid = value.user!.uid.toString();       // this Session will store current user ID that will be useful for showing current user profile info

        Get.offAll(() => const VerifyEmailPage());
        Get.snackbar("Success", "Login Successfully:)");



      }).onError((error, stackTrace){
    Get.snackbar("Error", error.toString() );
      });
      

    }catch(error){
      Get.snackbar("Error", error.toString() );

    }


  }
}