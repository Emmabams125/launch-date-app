import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  //personal info
  String? uid;
  String? imageProfile;
  String? gender;
  int? age;
  String? name;
  String? phoneNo;
  String? country;
  String? city;
  String? profileHeading;
  String? lookingForInaPartner;
  int? publishedDateTime;

  //Appearance
  String? height;
  String? weight;
  String? bodyType;

  //Lifestyle
  String? maritalStatus;
  String? numberOfChildren;
  String? profession;

  //background
  String? nationality;
  String? language;
  String? religion;
  String? ethnicity;

  //login details
  String? email;
  String? password;

  Person({
    this.uid,
    this.imageProfile,
    this.name,
    this.gender,
    this.age,
    this.phoneNo,
    this.country,
    this.city,
    this.profileHeading,
    this.lookingForInaPartner,
    this.publishedDateTime,
    this.height,
    this.weight,
    this.bodyType,
    this.maritalStatus,
    this.numberOfChildren,
    this.profession,
    this.nationality,
    this.language,
    this.religion,
    this.ethnicity,
    this.email,
    this.password,
  });

  static Person fromDataSnapshot(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return Person(
      // Personal info
      uid: dataSnapshot["uid"],
      name: dataSnapshot["name"],
      gender: dataSnapshot["gender"],
      imageProfile: dataSnapshot["imageProfile"],
      age: dataSnapshot["age"],
      phoneNo: dataSnapshot["phoneNo"],
      country: dataSnapshot["country"],
      city: dataSnapshot["city"],
      profileHeading: dataSnapshot["profileHeading"],
      lookingForInaPartner: dataSnapshot["lookingForInaPartner"],
      publishedDateTime: dataSnapshot["publishedDateTime"],

      // Appearance
      height: dataSnapshot["height"],
      weight: dataSnapshot["weight"],
      bodyType: dataSnapshot["bodyType"],

      // Lifestyle
      maritalStatus: dataSnapshot["maritalStatus"],
      numberOfChildren: dataSnapshot["numberOfChildren"],
      profession: dataSnapshot["profession"],

      // Background
      nationality: dataSnapshot["nationality"],
      language: dataSnapshot["language"],
      religion: dataSnapshot["religion"],
      ethnicity: dataSnapshot["ethnicity"],

      // Login details
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "imageProfile": imageProfile,
        "name": name,
        "gender": gender,
        "age": age,
        "phoneNo": phoneNo,
        "country": country,
        "city": city,
        "profileHeading": profileHeading,
        "lookingForInaPartner": lookingForInaPartner,
        "publishedDateTime": publishedDateTime,
        "height": height,
        "weight": weight,
        "bodyType": bodyType,
        "maritalStatus": maritalStatus,
        "numberOfChildren": numberOfChildren,
        "profession": profession,
        "nationality": nationality,
        "language": language,
        "religion": religion,
        "ethnicity": ethnicity,
        "email": email,
        "password": password,
      };
}
