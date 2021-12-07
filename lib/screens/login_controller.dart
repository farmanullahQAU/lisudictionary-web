import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/auth_services.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/models/user_model.dart';

class LoginRegisterController extends GetxController {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  RxInt currentIndex = 0.obs;

  changeIndex(int index) {
    this.currentIndex = index.obs;
    update();
  }

  // List<Widget> loginRegister=[
  //
  // LoginForm(),
  //   RegisterForm()
  //
  // ];

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.onInit();
  }

  Future registerUser() async {
    try {
      final UserCredential userCredential = await Get.find<AuthService>()
          .signUpWithEmailAndPassword(
              email: emailController?.text, password: passwordController?.text);
      //After signup add user details to firestore
      final user = UserModel(
          email: emailController?.text,
          name: nameController?.text,
          isAdmin: false);
      await Get.find<FirestoreService>()
          .addUser(user, userCredential.user?.uid);
      Get.back();
    } catch (error) {
      print("error");
      Get.back();
    }
  }

  Future loginUser() async {
    final UserCredential? user = await Get.find<AuthService>()
        .loginWithEmailAndPassword(
            email: emailController?.text, password: passwordController?.text);
    await Get.find<GetStorageServices>().saveId(user?.user?.uid);
  }
}
