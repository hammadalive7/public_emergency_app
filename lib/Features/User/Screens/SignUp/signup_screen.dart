import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_emergency_app/Features/User/Screens/SignUp/signup_form_widget.dart';

import '../../../../Common Widgets/form_footer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false, appBar: AppBar(
      backgroundColor: Colors.lightBlueAccent,
      centerTitle: true,
      automaticallyImplyLeading: false,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),

      bottom: PreferredSize(
          preferredSize:  Size.fromHeight(Get.height * 0.1),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image(image: const AssetImage("assets/logos/emergencyAppLogo.png"), height: Get.height * 0.1),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  const [
                      Text(
                        "Sign Up",
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
            children: const [
              SignUpFormWidget(),
              FooterWidget(Texts: "Already have Account ",Title: "Login")
            ],
          ),
        ),
      ),
    );
  }
}




