import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';

class AuthService extends GetxService{

  Future<AuthService> init() async {
    return this;
  }


  final auth=FirebaseAuth.instance;




  Future<UserCredential> signUpWithEmailAndPassword({@required String? email,@required String? password})async{
    try{
       return await auth.createUserWithEmailAndPassword(email: email!, password: password!);

    }
    catch(e){
      rethrow;
    }
  }

  Future<UserCredential> loginWithEmailAndPassword({@required String? email,@required String? password})async{
    try{
     return await auth.signInWithEmailAndPassword(email: email!, password: password!);
    }
    catch(e){
      rethrow;
    }
  }

  Future signOut()async{

    await auth.signOut();
  await Get.find<GetStorageServices>().saveId("");
  }

}