import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';

class AuthService extends GetxService {
  //firebase login and signup

  Future<AuthService> init() async {
    return this;
  }

  final auth = FirebaseAuth.instance;

  Future<UserCredential> signUpWithEmailAndPassword(
      {@required String? email, @required String? password}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> loginWithEmailAndPassword(
      {@required String? email, @required String? password}) async {
    return await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }

  Future signOut() async {
    await auth.signOut();
    //remove user id from local storeage
    await Get.find<GetStorageServices>().saveId("");
    //save role e.g admin or contributor
    await Get.find<GetStorageServices>().saveRole(false);
  }
}
