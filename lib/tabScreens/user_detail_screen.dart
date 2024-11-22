import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:launch_date_app/global.dart';
import 'package:launch_date_app/pages/settings_page.dart';
import '../componets/my_drawer.dart';

class UserDetailScreen extends StatefulWidget {
  String? userID;

  UserDetailScreen({super.key, this.userID});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  //personal info
  String imageProfile = '';
  String name = '';
  String gender = '';
  String age = '';
  String phoneNo = '';
  String country = '';
  String image = '';
  String city = '';
  String profileHeading = '';
  String lookingForInaPartner = '';

  //Appearance
  String height = '';
  String weight = '';
  String bodyType = '';

  //lifestyle
  String maritalStatus = '';
  String numberOfChildren = '';
  String profession = '';

  //background
  String nationality = '';
  String language = '';
  String religion = '';
  String ethnicity = '';

  //slider images
  String urlImage1 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-708cb.appspot.com/o/Place%20Holder%2F%E2%80%94Pngtree%E2%80%94user%20vector%20avatar_4830521.png?alt=media&token=d3d7dc7a-4b1f-404e-86c0-d33a028f3dc5";
  String urlImage2 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-708cb.appspot.com/o/Place%20Holder%2F%E2%80%94Pngtree%E2%80%94user%20vector%20avatar_4830521.png?alt=media&token=d3d7dc7a-4b1f-404e-86c0-d33a028f3dc5";
  String urlImage3 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-708cb.appspot.com/o/Place%20Holder%2F%E2%80%94Pngtree%E2%80%94user%20vector%20avatar_4830521.png?alt=media&token=d3d7dc7a-4b1f-404e-86c0-d33a028f3dc5";
  String urlImage4 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-708cb.appspot.com/o/Place%20Holder%2F%E2%80%94Pngtree%E2%80%94user%20vector%20avatar_4830521.png?alt=media&token=d3d7dc7a-4b1f-404e-86c0-d33a028f3dc5";
  String urlImage5 =
      "https://firebasestorage.googleapis.com/v0/b/dating-app-708cb.appspot.com/o/Place%20Holder%2F%E2%80%94Pngtree%E2%80%94user%20vector%20avatar_4830521.png?alt=media&token=d3d7dc7a-4b1f-404e-86c0-d33a028f3dc5";

  retrieveUserInfo() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          // Slider images with default URLs
          urlImage1 = snapshot.data()?["urlImage1"] ??
              "https://firebasestorage.googleapis.com/v0/b/dating-app-708cb.appspot.com/o/Place%20Holder%2F%E2%80%94Pngtree%E2%80%94user%20vector%20avatar_4830521.png?alt=media&token=d3d7dc7a-4b1f-404e-86c0-d33a028f3dc5";
          urlImage2 = snapshot.data()?["urlImage2"] ?? urlImage1;
          urlImage3 = snapshot.data()?["urlImage3"] ?? urlImage1;
          urlImage4 = snapshot.data()?["urlImage4"] ?? urlImage1;
          urlImage5 = snapshot.data()?["urlImage5"] ?? urlImage1;

          // Personal Info with default values
          name = snapshot.data()?["name"] ?? "Unknown Name";
          gender = snapshot.data()?["gender"] ?? "Unknown Gender";
          age = snapshot.data()?["age"]?.toString() ?? "Unknown Age";
          phoneNo = snapshot.data()?["phoneNo"] ?? "Unknown Phone";
          country = snapshot.data()?["country"] ?? "Unknown Country";
          city = snapshot.data()?["city"] ?? "Unknown City";
          profileHeading = snapshot.data()?["profileHeading"] ?? "No Heading";
          lookingForInaPartner =
              snapshot.data()?["lookingForInaPartner"] ?? "Not Specified";

          // Appearance with default values
          height = snapshot.data()?["height"]?.toString() ?? "Unknown Height";
          weight = snapshot.data()?["weight"]?.toString() ?? "Unknown Weight";
          bodyType = snapshot.data()?["bodyType"] ?? "Not Specified";

          // Lifestyle with default values
          maritalStatus = snapshot.data()?["maritalStatus"] ?? "Unknown Status";
          numberOfChildren =
              snapshot.data()?["numberOfChildren"]?.toString() ?? "None";
          profession = snapshot.data()?["profession"] ?? "Unknown Profession";

          // Background with default values
          nationality =
              snapshot.data()?["nationality"] ?? "Unknown Nationality";
          language = snapshot.data()?["language"] ?? "Unknown Language";
          religion = snapshot.data()?["religion"] ?? "Not Specified";
          ethnicity = snapshot.data()?["ethnicity"] ?? "Not Specified";
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true, // Extends the body behind the AppBar
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(color: Colors.red),
        ),

        centerTitle: true,
        leading: widget.userID != currentUserID
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 30,
                ),
              )
            : Container(),
        actions: [
          widget.userID == currentUserID
              ? Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(SettingsPage());
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
        //  automaticallyImplyLeading:widget.userID == currentUserID ? false : true,

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            children: [
              //image slider
              ClipRect(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Carousel(
                    indicatorBarColor: Colors.transparent,
                    autoScrollDuration: const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor:
                        Theme.of(context).colorScheme.primary,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 10,
                    indicatorBarWidth: MediaQuery.of(context).size.width * 0.5,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(
                        urlImage1,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Image.network(
                        urlImage2,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Image.network(
                        urlImage3,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Image.network(
                        urlImage4,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Image.network(
                        urlImage5,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //personal info title
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Personal Info:",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.red,
                thickness: 2,
              ),
              //personal info table data
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        const Text(
                          "Name:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          name,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    //extra table
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //personal info
                    //age
                    TableRow(
                      children: [
                        const Text(
                          "Age:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          age,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //gender
                    TableRow(
                      children: [
                        const Text(
                          "Gender:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          gender,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //phoneNo
                    TableRow(
                      children: [
                        const Text(
                          "Phone Number:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          phoneNo,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //country
                    TableRow(
                      children: [
                        const Text(
                          "Country:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          country,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //city
                    TableRow(
                      children: [
                        const Text(
                          "City:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          city,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //profile heading
                    TableRow(
                      children: [
                        const Text(
                          "Profile Heading:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          profileHeading,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //looking for in a partner
                    TableRow(
                      children: [
                        const Text(
                          "Looking for in a partner:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          lookingForInaPartner,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    //appearance
                  ],
                ),
              ),
              //appearance title heading
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Appearance:",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.red,
                thickness: 2,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //height
                    TableRow(
                      children: [
                        const Text(
                          "Height:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          height,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //weight
                    TableRow(
                      children: [
                        const Text(
                          "Weight:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          weight,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //body type
                    TableRow(
                      children: [
                        const Text(
                          "Body Type:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          bodyType,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Lifestyle:",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.red,
                thickness: 2,
              ),
              Container(
                child: Table(
                  children: [
                    //marital status
                    TableRow(
                      children: [
                        const Text(
                          "Marital Status:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          maritalStatus,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //number of children
                    TableRow(
                      children: [
                        const Text(
                          "Number of children:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          numberOfChildren,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //profession
                    TableRow(
                      children: [
                        const Text(
                          "Profession:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          profession,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Background:",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.red,
                thickness: 2,
              ),
              Container(
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        const Text(
                          "Nationality:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          nationality,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //language
                    TableRow(
                      children: [
                        const Text(
                          "Language:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          language,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    //religion
                    TableRow(
                      children: [
                        const Text(
                          "Religion:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          religion,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text(
                          "Ethnicity:",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          ethnicity,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
