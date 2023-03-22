import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Police",
      subtitle: "Emergency, Police ",
      event: "",
      img: "assets/logos/emergencyAppLogo.png");

  Items item2 = new Items(
    title: "FireBrigade",
    subtitle: "Emergency, FireBrigade",
    event: "",
    img: "assets/logos/emergencyAppLogo.png",
  );

  Items item3 = new Items(
    title: "Ambulance",
    subtitle: "Emergency, Ambulance",
    event: "",
    img: "assets/logos/emergencyAppLogo.png",
  );
  // Items item4 = new Items(
  //   title: "To do",
  //   subtitle: "Homework, Design",
  //   event: "4 Items",
  //   img: "assets/logos/emergencyAppLogo.png",
  // );


  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3];
    var color = 0xff453658;
    return GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 6, right: 6),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
                color: Color(color), borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  data.img,
                  width: 42,
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  data.title,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  data.subtitle,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  data.event,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        }).toList());
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({required this.title, required this.subtitle, required this.event, required this.img});
}