import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_date_app/controllers/authentication_controller.dart';
import 'package:launch_date_app/pages/login_page.dart';
import '../componets/my_button.dart';
import '../componets/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showProgressBar = false;

  //personal info
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Center(
                child: Image.asset(
                    'lib/images/heart/heart_with_chat_box_love_message_valentines_day_card.png',
                    height: 100)),
            const SizedBox(height: 25),
            // Message, app slogan
            Text(
              "Create your Account",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 25),

            //choose image circle avatar
            authenticationController.imageFile == null
                ? const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                        'lib/images/—Pngtree—user vector avatar_4830521.png'),
                  )
                : Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: FileImage(File(
                              authenticationController.imageFile!.path,
                            )))),
                  ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await authenticationController.pickImageFromGallery();

                    setState(() {
                      authenticationController.imageFile;
                    });
                  },
                  icon: const Icon(
                    Icons.image_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 25),
                IconButton(
                  onPressed: () async {
                    await authenticationController.captureImageFromCamera();

                    setState(() {
                      authenticationController.imageFile;
                    });
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                )
              ],
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Personal Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20),
                ),
              ),
            ),

            // name text field
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
                      color: Theme.of(context).colorScheme.inversePrimary,
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
                      color: Theme.of(context).colorScheme.inversePrimary,
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
                      color: Theme.of(context).colorScheme.inversePrimary,
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
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20),
                ),
              ),
            ),

            // Email text field
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(height: 10),

            // Password text field
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 10),

            // Confirm password text field
            MyTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Sign up button
            MyButton(
              onTap: () async {
                if (authenticationController.imageFile != null) {
                  if (
                      //personal info
                      nameController.text.trim().isNotEmpty &&
                          genderController.text.trim().isNotEmpty &&
                          phoneNoController.text.trim().isNotEmpty &&
                          ageController.text.trim().isNotEmpty &&
                          confirmPasswordController.text.trim().isNotEmpty &&
                          cityController.text.trim().isNotEmpty &&
                          countryController.text.trim().isNotEmpty &&
                          profileHeadingController.text.trim().isNotEmpty &&
                          lookingForInaPartnerController.text
                              .trim()
                              .isNotEmpty &&
                          emailController.text.trim().isNotEmpty &&
                          passwordController.text.trim().isNotEmpty &&
                          //appearance
                          heightController.text.trim().isNotEmpty &&
                          weightController.text.trim().isNotEmpty &&
                          bodyTypeController.text.trim().isNotEmpty &&
                          //lifestyle
                          maritalStatusController.text.trim().isNotEmpty &&
                          noOfChildrenController.text.trim().isNotEmpty &&
                          professionController.text.trim().isNotEmpty &&
                          //background
                          nationalityController.text.trim().isNotEmpty &&
                          languageController.text.trim().isNotEmpty &&
                          religionController.text.trim().isNotEmpty &&
                          ethnicityController.text.trim().isNotEmpty) {
                    setState(() {
                      showProgressBar = true;
                    });
                    await authenticationController.createNewUserAccount(
                      authenticationController.profileImage!,
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
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    setState(() {
                      showProgressBar = false;
                      authenticationController.imageFile = null;
                    });
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
                } else {
                  Get.snackbar(
                    "Image File Missing",
                    "Please pick an image from the gallery or capture with the camera.",
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              text: "Sign Up",
            ),

            const SizedBox(height: 25),

            // Already have an account? Login here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(onTap: () {})),
                    );
                  },
                  child: Text(
                    "Login here",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
