import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:launch_date_app/models/person.dart' as personModel;
import 'package:launch_date_app/pages/home_page.dart';
import 'package:launch_date_app/pages/login_page.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();

  late Rx<User?> firebaseCurrentUser;

  late Rx<File?> pickedFile = Rx<File?>(null);
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  pickImageFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully picked your profile image");
      pickedFile.value = File(imageFile!.path);
    }
  }

  captureImageFromCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully captured your profile image");
      pickedFile.value = File(imageFile!.path);
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    Reference referenceStorage = FirebaseStorage.instance
        .ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask task = referenceStorage.putFile(imageFile);
    TaskSnapshot snapshot = await task;

    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();
    return downloadUrlOfImage;
  }

  Future<void> createNewUserAccount(
    File imageProfile,
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

    // login details
    String email,
    String password,
  ) async {
    try {
      // 1. Authenticate user with email and password
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Upload image to storage and get download URL
      String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);

      // 3. Create a new Person instance
      personModel.Person personInstance = personModel.Person(
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        name: name,
        gender: gender,
        age: int.parse(age),
        phoneNo: phoneNo,
        country: country,
        city: city,
        profileHeading: profileHeading,
        lookingForInaPartner: lookingForInaPartner,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
        height: height,
        weight: weight,
        bodyType: bodyType,
        maritalStatus: maritalStatus,
        numberOfChildren: numberOfChildren,
        profession: profession,
        nationality: nationality,
        language: language,
        religion: religion,
        ethnicity: ethnicity,
        email: email,
        password: password,
      );

      // 4. Save to Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());

      Get.snackbar("Account Created", "User account created successfully!");
      Get.to(() => HomePage()); // Updated here
    } catch (errorMsg) {
      Get.snackbar(
          "Account Creation Unsuccessful", "Error occurred: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailUser,
        password: passwordUser,
      );
      Get.snackbar("Login successful", "You are logged in successfully");

      Get.to(() => HomePage()); // Updated here
    } catch (errorMsg) {
      Get.snackbar("Login Unsuccessful", "Error occurred: $errorMsg");
    }
  }

  checkIfUserIsLoggedIn(User? currentUser) {
    if (currentUser == null) {
      Get.to(() => LoginPage(onTap: () {})); // Updated here
    } else {
      Get.to(() => HomePage()); // Updated here
    }
  }

  @override
  void onReady() {
    super.onReady();

    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }
}
