


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Screens/Profile/profile_screen_form.dart';
import '../../../Login/login_screen.dart';
import '../../controllers/session_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context){

    return Scaffold(
      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        shape: StadiumBorder(
            side: BorderSide(
                color: Colors.white24, width: 4)),
        onPressed: () { FirebaseAuth auth = FirebaseAuth.instance;

        auth.signOut().then((value){
          SessionController().userid = '';
          Get.offAll(() => const LoginScreen());
        });},
        child: Icon(Icons.logout_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,


      extendBodyBehindAppBar: false,
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
            preferredSize: const Size.fromHeight(110.0),
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image(image: AssetImage("assets/logos/emergencyAppLogo.png"), height: 100),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "Profile",
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children:  [
              ProfileFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}



