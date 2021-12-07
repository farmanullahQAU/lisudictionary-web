import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/screens/dictionary_form/dictionary_form_view.dart';
import 'package:lisudictionary_web/screens/login/login_view.dart';
import 'package:lisudictionary_web/screens/home/home.dart';
import 'package:lisudictionary_web/screens/register/register_contributor_view.dart';
import 'package:lisudictionary_web/screens/splash_view/splash_view.dart';

List<GetPage> pages = [
  GetPage(name: "/login", page: () => LoginView()),
  //to restrict user from typing route in url without login
  GetPage(
      name: "/home",
      page: () =>
          Get.find<GetStorageServices>().getId == "" ? SplashView() : Home()),
  GetPage(
      name: "/wordsform",
      page: () => Get.find<GetStorageServices>().getId == ""
          ? SplashView()
          : DictionarForm()),
  GetPage(
      name: "/register",
      page: () => Get.find<GetStorageServices>().getId == ""
          ? SplashView()
          : RegisterView()),

  GetPage(name: "/", page: () => SplashView()),
];
