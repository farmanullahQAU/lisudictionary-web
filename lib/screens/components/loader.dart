import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Future showLoading() async {

 return await showDialog(
      context: Get.context!,
      builder: (_) {
        return Lottie.asset("assets/lottie/loader.json",
            width: Get.width * 0.2);
      });
}