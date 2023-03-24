import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Controllers/session_controller.dart';

import '../../../Login/login_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              // final user = auth.currentUser;
              FirebaseAuth auth = FirebaseAuth.instance;

              auth.signOut().then((value){
                SessionController().userid = '';
                Get.offAll(() => const LoginScreen());
              });

            }, child: Text("Logout")),
            const SizedBox(
              height: 100,
            ),
            const Center(
              child: Text('User Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
