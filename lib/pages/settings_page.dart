import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launch_date_app/global.dart';
import 'package:launch_date_app/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../componets/my_button.dart';
import '../componets/my_textfield.dart';
import '../themes/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  double val = 0;

  //personal info
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController profileHeadingController = TextEditingController();
  TextEditingController lookingForInaPartnerController =
      TextEditingController();

  //appearance
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyTypeController = TextEditingController();

  //life style
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController haveChildrenController = TextEditingController();
  TextEditingController noOfChildrenController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController employmentStatusController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController livingSituationController = TextEditingController();
  TextEditingController willingController = TextEditingController();
  TextEditingController relationshipYouAreLookingForController =
      TextEditingController();

  //background- cultural values
  TextEditingController nationalityController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();

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

  chooseImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

  uploadImages() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      var refImages = FirebaseStorage.instance.ref().child(
          "images/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg");

      await refImages.putFile(img).whenComplete(() async {
        await refImages.getDownloadURL().then((urlImage) {
          urlsList.add(urlImage);

          i++;
        });
      });
    }
  }

  retrieveUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          // Personal Info with default values
          name = snapshot.data()?["name"] ?? "Unknown Name";
          nameController.text = name;
          gender = snapshot.data()?["gender"] ?? "Unknown Gender";
          genderController.text = gender;
          age = snapshot.data()?["age"]?.toString() ?? "Unknown Age";
          ageController.text = gender;
          phoneNo = snapshot.data()?["phoneNo"] ?? "Unknown Phone";
          phoneNoController.text = phoneNo;
          country = snapshot.data()?["country"] ?? "Unknown Country";
          countryController.text = country;
          city = snapshot.data()?["city"] ?? "Unknown City";
          cityController.text = city;
          profileHeading = snapshot.data()?["profileHeading"] ?? "No Heading";
          profileHeadingController.text = profileHeading;
          lookingForInaPartner =
              snapshot.data()?["lookingForInaPartner"] ?? "Not Specified";
          lookingForInaPartnerController.text = lookingForInaPartner;

          // Appearance with default values
          height = snapshot.data()?["height"]?.toString() ?? "Unknown Height";
          heightController.text = height;
          weight = snapshot.data()?["weight"]?.toString() ?? "Unknown Weight";
          weightController.text = weight;
          bodyType = snapshot.data()?["bodyType"] ?? "Not Specified";
          bodyTypeController.text = bodyType;

          // Lifestyle with default values
          maritalStatus = snapshot.data()?["maritalStatus"] ?? "Unknown Status";
          maritalStatusController.text = maritalStatus;
          numberOfChildren =
              snapshot.data()?["numberOfChildren"]?.toString() ?? "None";
          noOfChildrenController.text = numberOfChildren;
          profession = snapshot.data()?["profession"] ?? "Unknown Profession";
          professionController.text = profession;

          // Background with default values
          nationality =
              snapshot.data()?["nationality"] ?? "Unknown Nationality";
          nationalityController.text = nationality;
          language = snapshot.data()?["language"] ?? "Unknown Language";
          languageController.text = language;
          religion = snapshot.data()?["religion"] ?? "Not Specified";
          religionController.text = religion;
          ethnicity = snapshot.data()?["ethnicity"] ?? "Not Specified";
          ethnicityController.text = ethnicity;
        });
      }
    });
  }

  updateUserDataToFirestoreDatabase(
    String name,
    String gender,
    String age,
    String phoneNo,
    String country,
    String city,
    String profileHeading,
    String lookingForInaPartner,

    // appearance
    String height,
    String weight,
    String bodyType,

    // lifestyle
    String maritalStatus,
    String numberOfChildren,
    String profession,

    // background
    String nationality,
    String language,
    String religion,
    String ethnicity,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("uploading images...")
                ],
              ),
            ),
          ),
        );
      },
    );

    await uploadImages();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .update({
      //personal info
      ' name': name,
      'gender': gender,
      'age': int.parse(age),
      'phoneNo': phoneNo,
      'country': country,
      'city': city,
      'profileHeading': profileHeading,
      'lookingForInaPartner': lookingForInaPartner,

      //appearance
      'eight': height,
      'weight': weight,
      'bodyType': bodyType,
      //lifestyle
      'maritalStatus': maritalStatus,
      'numberOfChildren': numberOfChildren,
      'profession': profession,
      //background
      'nationality': nationality,
      'language': language,
      'religion': religion,
      'ethnicity': ethnicity,
      //images
      'urlImages1': urlsList[0].toString(),
      'urlImages2': urlsList[1].toString(),
      'urlImages3': urlsList[2].toString(),
      'urlImages4': urlsList[3].toString(),
      'urlImages5': urlsList[4].toString(),
    });

    Get.snackbar("Updated", "your account has been updated successfully");

    Get.to(HomePage());

    setState(() {
      uploading = false;
      _image.clear();
      urlsList.clear();
    });
  }

  @override
  void initState() {
    //TODO : implement initState
    super.initState();

    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            next ? "Profile Information" : "Choose 5 Images",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            next
                ? Container()
                : IconButton(
                    onPressed: () {
                      if (_image.length == 5) {
                        setState(() {
                          uploading = true;
                          next = true;
                        });
                      } else {
                        Get.snackbar("5 Images", "Please choose 5 images");
                      }
                    },
                    icon: const Icon(
                      Icons.navigate_next_outlined,
                      size: 36,
                    ),
                  ),
          ],
        ),
        body: next
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Personal Info",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20),
                      ),
                      MyTextField(
                        controller: nameController,
                        hintText: "Name",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      MyTextField(
                        controller: genderController,
                        hintText: "gender",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      MyTextField(
                        controller: ageController,
                        hintText: "Age",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      // PhoneNO text field
                      MyTextField(
                        controller: phoneNoController,
                        hintText: "Phone Number",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      // country text field
                      MyTextField(
                        controller: countryController,
                        hintText: "Country",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      // city text field
                      MyTextField(
                        controller: cityController,
                        hintText: "City",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      // profile heading text field
                      MyTextField(
                        controller: profileHeadingController,
                        hintText: "Profile heading",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      // looking for in a partner text field
                      MyTextField(
                        controller: lookingForInaPartnerController,
                        hintText: "Looking for in a partner",
                        obscureText: false,
                      ),
                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Appearance",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      // height text field
                      MyTextField(
                        controller: heightController,
                        hintText: "Height",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      // weight text field
                      MyTextField(
                        controller: weightController,
                        hintText: "Weight",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      // body type text field
                      MyTextField(
                        controller: bodyTypeController,
                        hintText: "Body Type",
                        obscureText: false,
                      ),
                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Lifestyle",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      MyTextField(
                        controller: maritalStatusController,
                        hintText: "Marital Status",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      MyTextField(
                        controller: noOfChildrenController,
                        hintText: "Number of children",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      MyTextField(
                        controller: professionController,
                        hintText: "profession",
                        obscureText: false,
                      ),
                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Background",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      MyTextField(
                        controller: nationalityController,
                        hintText: "Nationality",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      MyTextField(
                        controller: languageController,
                        hintText: "Language",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      MyTextField(
                        controller: religionController,
                        hintText: "Religion",
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),

                      MyTextField(
                        controller: ethnicityController,
                        hintText: "Ethnicity",
                        obscureText: false,
                      ),

                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      MyButton(
                        onTap: () async {
                          if (
                              //personal info
                              nameController.text.trim().isNotEmpty &&
                                  genderController.text.trim().isNotEmpty &&
                                  phoneNoController.text.trim().isNotEmpty &&
                                  ageController.text.trim().isNotEmpty &&
                                  cityController.text.trim().isNotEmpty &&
                                  countryController.text.trim().isNotEmpty &&
                                  profileHeadingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  lookingForInaPartnerController.text
                                      .trim()
                                      .isNotEmpty &&
                                  //appearance
                                  heightController.text.trim().isNotEmpty &&
                                  weightController.text.trim().isNotEmpty &&
                                  bodyTypeController.text.trim().isNotEmpty &&
                                  //lifestyle
                                  maritalStatusController.text
                                      .trim()
                                      .isNotEmpty &&
                                  noOfChildrenController.text
                                      .trim()
                                      .isNotEmpty &&
                                  professionController.text.trim().isNotEmpty &&
                                  //background
                                  nationalityController.text
                                      .trim()
                                      .isNotEmpty &&
                                  languageController.text.trim().isNotEmpty &&
                                  religionController.text.trim().isNotEmpty &&
                                  ethnicityController.text.trim().isNotEmpty) {
                            _image.length > 0
                                ? await updateUserDataToFirestoreDatabase(
                                    nameController.text.trim(),
                                    genderController.text.trim(),
                                    ageController.text.trim(),
                                    phoneNoController.text.trim(),
                                    countryController.text.trim(),
                                    cityController.text.trim(),
                                    profileHeadingController.text.trim(),
                                    lookingForInaPartnerController.text.trim(),
                                    heightController.text.trim(),
                                    weightController.text.trim(),
                                    bodyTypeController.text.trim(),
                                    maritalStatusController.text.trim(),
                                    noOfChildrenController.text.trim(),
                                    professionController.text.trim(),
                                    nationalityController.text.trim(),
                                    languageController.text.trim(),
                                    religionController.text.trim(),
                                    ethnicityController.text.trim(),
                                  )
                                : null;
                          } else {
                            Get.snackbar(
                              "A field is empty",
                              "Please fill out all fields in the form.",
                              snackPosition: SnackPosition.TOP,
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          }
                        },
                        text: "Update",
                      ),

                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: GridView.builder(
                      itemCount: _image.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        if (_image.length < 5) {
                                          !uploading ? chooseImage() : null;
                                        } else {
                                          setState(() {
                                            uploading == true;
                                          });
                                          Get.snackbar(
                                              "5 Images Already Selected",
                                              "Shey you no see na 5 u suppose puts");
                                        }
                                      },
                                      icon: const Icon(Icons.add)),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      _image[index - 1],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                      },
                    ),
                  )
                ],
              ));
  }
}
