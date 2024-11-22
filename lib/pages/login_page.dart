import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:launch_date_app/componets/my_button.dart';
import 'package:launch_date_app/controllers/authentication_controller.dart';
import 'package:launch_date_app/pages/home_page.dart';
import 'package:launch_date_app/pages/register_page.dart';
import '../componets/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showProgressBar = false;
  var controllerAuth = AuthenticationController.authController;

  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Center(
              child: Image.asset(
                  'lib/images/heart/heart_with_chat_box_love_message_valentines_day_card.png',
                  height: 100)),
          const SizedBox(height: 25),

          Text(
            "Victoria's Launch Date",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 25),

          //email textfield
          MyTextField(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
          ),

          const SizedBox(height: 25),

          //password textfield
          MyTextField(
            controller: passwordController,
            hintText: "password",
            obscureText: true,
          ),

          const SizedBox(height: 25),

          //log in
          MyButton(
              onTap: () async {
                if (emailController.text.trim().isNotEmpty &&
                    passwordController.text.trim().isNotEmpty) {
                  setState(() {
                    showProgressBar = true;
                  });
                  await controllerAuth.loginUser(emailController.text.trim(),
                      passwordController.text.trim());
                  setState(() {
                    showProgressBar = false;
                  });
                } else {
                  Get.snackbar(
                    "Email/Password is Missing",
                    "Please fill out all fields .",
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              text: "Login"),

          const SizedBox(height: 25),

          //not a member? register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Register now",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
