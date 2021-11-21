import 'package:get/get.dart';
import 'package:lisudictionary_web/screens/dashboard/components/login.dart';
import 'package:lisudictionary_web/screens/main/main_screen.dart';
import 'package:lisudictionary_web/ui/splash_view.dart';



List<GetPage> pages = [
  GetPage(name: "/home", page: () => LoginView()),
  GetPage(name: "/splash", page: () => SplashView()),

];
