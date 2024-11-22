import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:launch_date_app/controllers/authentication_controller.dart';
import 'package:launch_date_app/models/launchdate.dart';
import 'package:provider/provider.dart';
import 'package:launch_date_app/pages/login_page.dart';
import 'package:launch_date_app/themes/theme_provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    Get.put(
        AuthenticationController()); // Initialize AuthenticationController with GetX
  });

  runApp(
    MultiProvider(
      providers: [
        // Theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        // LaunchDate model provider
        ChangeNotifierProvider(create: (context) => LaunchDate()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(onTap: () {}),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
