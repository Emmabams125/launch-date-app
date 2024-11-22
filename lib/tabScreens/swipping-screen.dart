import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_date_app/controllers/profile-controller.dart';
import 'package:launch_date_app/global.dart';
import 'package:launch_date_app/tabScreens/user_detail_screen.dart';

class SwipingScreen extends StatefulWidget {
  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {
  ProfileController profileController = Get.put(ProfileController());
  String senderName = "";

  readCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot) {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
              itemCount: profileController.allUsersProfileList.length,
              controller: PageController(initialPage: 0, viewportFraction: 1),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final eachProfileInfo =
                    profileController.allUsersProfileList[index];

                return DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        eachProfileInfo.imageProfile.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        //filter icon button
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.filter_list,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                          ),
                        ),
                        const Spacer(),

                        //user data
                        GestureDetector(
                          onTap: () {
                            profileController.viewSentAndViewReceived(
                                eachProfileInfo.uid.toString(), senderName);
                            //send user to profile person userDetailScreen
                            Get.to(UserDetailScreen(
                              userID: eachProfileInfo.uid.toString(),
                            ));
                          },
                          child: Column(
                            children: [
                              //name
                              Text(
                                eachProfileInfo.name.toString(),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              //age-city
                              Text(
                                eachProfileInfo.age.toString() +
                                    "⦾" +
                                    eachProfileInfo.city.toString(),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              //work and religion
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                    child: Text(
                                      eachProfileInfo.profession.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                    child: Text(
                                      eachProfileInfo.religion.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              //country nd ethnicity
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                    child: Text(
                                      eachProfileInfo.country.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                    child: Text(
                                      eachProfileInfo.ethnicity.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        //image button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //favorite button
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  profileController
                                      .favoriteSentAndFavoriteReceived(
                                          eachProfileInfo.uid.toString(),
                                          senderName);
                                },
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    "lib/images/vecteezy_star_1189165.png",
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ),
                            ),
                            //chat button
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                    "lib/images/comment_12891555.png",
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ),
                            ),
                            // heart button
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  profileController.likeSentAndLikeReceived(
                                      eachProfileInfo.uid.toString(),
                                      senderName);
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset(
                                    "lib/images/cute_15675380.png",
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
