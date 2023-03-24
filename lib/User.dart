import 'package:firebase_database/firebase_database.dart';

class AppUser{
  late String name;
  late String email;
  late String phone;
  late String userType;
  late String id;
  String? imageUrl;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? latitude;
  String? longitude;

  AppUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    required this.id,
    this.imageUrl,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.latitude,
    this.longitude,
  });
  AppUser.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key!;

    var data = dataSnapshot.value as Map?;

    if (data != null) {
      email = data["email"];
      name = data["UserName"];
      phone = data["Phone"];
      userType = data["UserType"];
    }
  }
}