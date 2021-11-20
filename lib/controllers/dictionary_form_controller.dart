import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/models/word_model.dart';
import 'package:lisudictionary_web/screens/dashboard/components/recent_files.dart';

class DictFormController extends GetxController{
  TextEditingController? wordController;
  TextEditingController? engDefController;

  TextEditingController? engExample1Controller;

  TextEditingController? engExample2Controller;
  TextEditingController? lisuDefController;

  TextEditingController? lisuExample1Controller;

  TextEditingController? lisuExample2Controller;
  TextEditingController? burmeseDefController;

  TextEditingController? burmeseExample1Controller;

  TextEditingController? burmeseExample2Controller;

  GlobalKey<FormState>? formKey=GlobalKey<FormState>();
  @override
  void onInit() {
    wordController=TextEditingController();
    engDefController=TextEditingController();
    lisuDefController=TextEditingController();
    burmeseDefController=TextEditingController();

    engExample1Controller=TextEditingController();
    engExample2Controller=TextEditingController();
    burmeseExample1Controller=TextEditingController();
    burmeseExample2Controller=TextEditingController();

    lisuExample1Controller=TextEditingController();
    lisuExample2Controller=TextEditingController();

    super.onInit();
  }

  addWord()
  async {

    final word = Word(
      isVerified: false,
      word: wordController?.text,
      engDefinition:
      engDefController?.text,
      lisuDefinition:
          lisuDefController?.text,
      burmerDefinition:
          burmeseDefController?.text,
      engExamples: <String>[
        engExample1Controller
            ?.text ??
            "",
        engExample2Controller
            ?.text ??
            ""
      ],
      lisuExamples: <String>[
        lisuExample1Controller
            ?.text ??
            "",
        lisuExample2Controller
            ?.text ??
            ""
      ],
      burmerExamples: <String>[
        burmeseExample1Controller
            ?.text ??
            "",
        burmeseExample2Controller
            ?.text ??
            ""
      ],
    );

    await Get.find<FirestoreService>().addWord(word);
    print('aaddddedd successfully');

  }


}