import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Controllers/session_controller.dart';

import '../Screens/SignUp/verify_email_page.dart';


// SignUpController is used to store user data will he signup and alse create User Email And Password Authentication for login

class SignUpController extends GetxController {


  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');

  // final userRepo = Get.put(UserRepository());

  void signUp(String username, String email, String password, String Phone)async{

    FirebaseAuth auth = FirebaseAuth.instance;


    UserCredential? userCredential;
    try{
       userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){

        SessionController().userid = value.user!.uid.toString();

        ref.child(value.user!.uid.toString()).set({
          'email': value.user!.email.toString(),
          // 'password': password,
          'UserName': username,
          'Phone' : Phone,

        });


          Get.offAll(() => const VerifyEmailPage());
          Get.snackbar("Success", "SignUp Successfully:)");

      }).onError((error, stackTrace){
    Get.snackbar("Error", error.toString() );
      });
    } catch (error) {
      Get.snackbar("Error", error.toString() );
    }
  }
  }
  