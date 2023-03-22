import 'package:flutter/material.dart';
import 'package:public_emergency_app/Features/User/Screens/SignUp/signup_form_widget.dart';

import '../../../../Common Widgets/form_footer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // SizedBox(width: 15,),
                      // Center(
                      //   child: SizedBox.fromSize(
                      //     size: Size(56, 56),
                      //     child: ClipOval(
                      //       child: Material(
                      //         color: Colors.black12,
                      //         child: InkWell(
                      //           splashColor: Colors.white,
                      //           onTap: () {  Get.back();
                      //           },
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),


                      Image(image: AssetImage("assets/logos/emergencyAppLogo.png"), height: 100),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
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




