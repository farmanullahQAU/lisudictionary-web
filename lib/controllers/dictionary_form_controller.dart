import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/models/word_model.dart';
import 'package:lisudictionary_web/screens/dashboard/components/recent_files.dart';

class DictFormController extends GetxController{
  bool isUpdate=false;
  //word clicked to update
  Word? currentWord;
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
    isUpdate=false;
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

  addOrUpdate()
  async {

    final word = Word(
      //
      isVerified:isUpdate==true?currentWord?.isVerified: false,
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
isUpdate==true?await  Get.find<FirestoreService>().updateWord(word,currentWord?.id):
    await Get.find<FirestoreService>().addWord(word);


  }



  initFields(Word word)
  {
    //initilize current word
    currentWord=word;
    wordController?.text=word.word??"";
    engDefController?.text=word.engDefinition??"";
    lisuDefController?.text=word.lisuDefinition??"";

    burmeseDefController?.text=word.burmerDefinition??"";


    engDefController?.text=word.engDefinition??"";
    if(word.engExamples!=null)
      {
        engExample1Controller?.text=word.engExamples![0];
        engExample2Controller?.text=word.engExamples![1];

      }
    if(word.burmerExamples!=null)
    {
      burmeseExample1Controller?.text=word.burmerExamples![0];
      burmeseExample2Controller?.text=word.burmerExamples![1];

    }
    if(word.lisuExamples!=null)
    {
      lisuExample1Controller?.text=word.lisuExamples![0];
      lisuExample2Controller?.text=word.lisuExamples![1];

    }


  }


}