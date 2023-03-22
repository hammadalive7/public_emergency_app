

import 'package:flutter/material.dart';
import 'package:public_emergency_app/Features/User/Screens/Login/login_form_widget.dart';


import '../../../../Common Widgets/form_footer.dart';


class LoginScreen extends StatelessWidget  {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                          "Login",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // (,
              LoginForm(),
              FooterWidget(Texts: "Don't Have Account ",Title: "Sign Up"),
            ],
          ),
        ),
      ),
    );
  }
}