import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/screens/login/login_view.dart';
import 'package:lisudictionary_web/screens/home/home.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //if user has logged out or cleard his local storage then go to login otherwise to home
    return Get.find<GetStorageServices>().getId != "" ? Home() : LoginView();
  }
}
