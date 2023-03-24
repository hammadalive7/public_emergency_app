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
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userid = value.user!.uid
            .toString(); // this Session will store current user ID that will be useful for showing current user profile info

        Get.offAll(() => const VerifyEmailPage());
        Get.snackbar("Success", "Login Successfully:)");
      }).onError((error, stackTrace) {
        if (error == null) {
          Get.snackbar("Error", "Please Enter Email & Password");
        } else if (error.toString().contains("user-not-found")) {
          Get.snackbar("Error", "User Not Found");
        } else if (error.toString().contains("wrong-password")) {
          Get.snackbar("Error", "Wrong Password");
        } else if (error.toString().contains("invalid-email")) {
          Get.snackbar("Error", "Invalid Email");
        } else if (error.toString().contains("network-request-failed")) {
          Get.snackbar("Error", "Network Error");
        } else if (error.toString().contains("too-many-requests")) {
          Get.snackbar("Error", "Too Many Requests");
        } else if (error.toString().contains("user-disabled")) {
          Get.snackbar("Error", "User Disabled");
        } else if (error.toString().contains("operation-not-allowed")) {
          Get.snackbar("Error", "Operation Not Allowed");
        } else if (error.toString().contains("invalid-credential")) {
          Get.snackbar("Error", "Invalid Credential");
        } else if (error
            .toString()
            .contains("account-exists-with-different-credential")) {
          Get.snackbar("Error", "Account Exists With Different Credential");
        } else if (error.toString().contains("requires-recent-login")) {
          Get.snackbar("Error", "Requires Recent Login");
        } else if (error.toString().contains("email-already-in-use")) {
          Get.snackbar("Error", "Email Already In Use");
        } else if (error.toString().contains("weak-password")) {
          Get.snackbar("Error", "Password Should Be At Least 6 Characters");
        } else if (error.toString().contains("invalid-email")) {
          Get.snackbar("Error", "Invalid Email");
        } else if (error.toString().contains("user-not-found")) {
          Get.snackbar("Error", "User Not Found");
        } else if (error.toString().contains("wrong-password")) {
          Get.snackbar("Error", "Wrong Password");
        } else if (error.toString().contains("invalid-email")) {
          Get.snackbar("Error", "Invalid Email");
        } else if (error.toString().contains("network-request-failed")) {
          Get.snackbar("Error", "Network Error");
        } else if (error.toString().contains("too-many-requests")) {
          Get.snackbar("Error", "Too Many Requests");
        }
      });
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }
}
