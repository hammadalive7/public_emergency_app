

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Screens/Login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Features/User/Controllers/session_controller.dart';
import '../Features/User/Screens/SignUp/verify_email_page.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final controller = PageController();
  bool lastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String url,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            SizedBox(height: Get.height * .02),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: Get.height*.03,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .10),
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            lastPage = index == 2;
          });
        },
        children: <Widget>[
          buildPage(
              color: Colors.white,
              url: "assets/logos/emergencyAppLogo.png",
              title: 'Quality Service',
              subtitle:
              'Get quality and professional services right at your footstep'),
          buildPage(
              color: Colors.white,
              url: 'assets/logos/emergencyAppLogo.png',
              title: 'Work Faster',
              subtitle:
              'Get more hands on board to help you do work faster and cleaner'),
          buildPage(
              color: Colors.white,
              url: 'assets/logos/emergencyAppLogo.png',
              title: 'Get Employed',
              subtitle:
              'Get discovered right from home and get paid for what you love doing '),
        ],
      ),
      bottomSheet: lastPage
          ? GestureDetector(
        onTap: () {

          final user = auth.currentUser;
          // Firebase.initializeApp().then((value) => Get.put(AuthenticationRepository()));
          if(user != null){
            SessionController().userid = user.uid.toString();
            Timer(Duration(seconds: 3), ()=> Get.offAll(() =>  VerifyEmailPage()));

          }else{
            // print("hello");
            Timer(Duration(seconds: 3), ()=> Get.offAll(() =>  LoginScreen()));

          }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const LoginScreen()),
          // );
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: Get.height * .08, bottom: Get.height * .08),
          child: Container(
              height: Get.height * .09,
              width: Get.width * .65,
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                  child: Text('Get Started',
                      style:
                      TextStyle(fontSize: 20, color: Colors.white)))),
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: Get.height * .02, left: Get.width * .01),
            child: TextButton(
                onPressed: () {

                  final user = auth.currentUser;
                  // Firebase.initializeApp().then((value) => Get.put(AuthenticationRepository()));
                  if(user != null){
                    SessionController().userid = user.uid.toString();
                    Timer(Duration(seconds: 3), ()=> Get.offAll(() =>  VerifyEmailPage()));

                  }else{
                    // print("hello");
                    Timer(Duration(seconds: 3), ()=> Get.offAll(() =>  LoginScreen()));

                  }

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>  const LoginScreen()),
                  // );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: 25, color: Colors.lightBlueAccent),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Get.height * .15),
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const WormEffect(
                spacing: 10,
                dotColor: Colors.black,
                activeDotColor: Colors.redAccent,
              ),
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: Get.width * .03, bottom: Get.height * .02),
            child: FloatingActionButton(
              onPressed: () {
                controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              backgroundColor: Colors.lightBlueAccent,
              child: const Center(
                child: Text(
                  '>',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}