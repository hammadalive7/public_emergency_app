import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/Ambulance/ambulance_dashboard.dart';
import 'package:public_emergency_app/Features/FireFighter/firefighter_dashboard.dart';
import 'package:public_emergency_app/Features/Police/police_dashboard.dart';
import 'package:public_emergency_app/Features/User/Screens/DashBoard/user_dashboard.dart';
import '../../../../User.dart';
import '../../../Login/login_screen.dart';
import '../../controllers/session_controller.dart';
import '../bottom_nav.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  String userType = "";
  bool canResendEmail = true;
  Widget Screen= const NavBar();
  Future<String> getUserType() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var ref =
        FirebaseDatabase.instance.ref().child('Users').child(firebaseUser!.uid);
    final snapshot = await ref.get(); // you should use await on async methods
    if (snapshot!.value != null) {
      var userCurrentInfo = AppUser.fromSnapshot(snapshot);
      setState(() {
        userType = userCurrentInfo.userType;
        debugPrint("User Type: $userType");
      });
      return userCurrentInfo.userType;
    } else {
      return "Error";
    }
  }

  screenAccordingToUser() async {
    await getUserType().then((value) {
      if (userType == "Police") {
        setState(() {
          Screen = const PoliceDashboard();
        });
        return const PoliceDashboard();
      } else if (userType == "FireFighter") {
        setState(() {
          Screen = const FirefighterDashboard();
        });
        return const FirefighterDashboard();
      } else if (userType == "Ambulance") {
        setState(() {
          Screen = const AmbulanceDashboard();
        });
        return const AmbulanceDashboard();
      } else {
        setState(() {
          Screen = const NavBar();
        });
        return const NavBar();
      }
    });
    return const NavBar();
  }

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    screenAccordingToUser();
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Screen
      : Scaffold(
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
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Verify Email",
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
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A Verification email has been sent to your email.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightBlueAccent,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  icon: const Icon(
                    Icons.email,
                    size: 32,
                  ),
                  label: const Text(
                    'Resend Email',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(20),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth.signOut().then((value) {
                      SessionController().userid = '';
                      Get.offAll(() => const LoginScreen());
                    });
                  },
                ),
              ],
            ),
          ),
        );
}
