import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/models/word_model.dart';

class DictFormController extends GetxController {
//this file contains all all methods for contributor add word forms

  bool isUpdate = false;
  RxBool isChanged = false.obs;
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

  GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  void clearFields() {
    wordController?.clear();
    engDefController?.clear();
    lisuDefController?.clear();
    burmeseDefController?.clear();

    engExample1Controller?.clear();
    engExample2Controller?.clear();
    burmeseExample1Controller?.clear();
    burmeseExample2Controller?.clear();

    lisuExample1Controller?.clear();
    lisuExample2Controller?.clear();
  }

  @override
  void onInit() {
    isUpdate = false;
    wordController = TextEditingController();
    engDefController = TextEditingController();
    lisuDefController = TextEditingController();
    burmeseDefController = TextEditingController();

    engExample1Controller = TextEditingController();
    engExample2Controller = TextEditingController();
    burmeseExample1Controller = TextEditingController();
    burmeseExample2Controller = TextEditingController();

    lisuExample1Controller = TextEditingController();
    lisuExample2Controller = TextEditingController();

    super.onInit();
  }

  checkChanges() {
    List<String>? englishExamples = [
      engExample1Controller?.text ?? "",
      engExample2Controller?.text ?? "",
    ];
    List<String>? lisuExamples = [
      lisuExample1Controller?.text ?? "",
      lisuExample2Controller?.text ?? "",
    ];
    List<String>? burmeseExmaples = [
      burmeseExample1Controller?.text ?? "",
      burmeseExample2Controller?.text ?? "",
    ];
    if (currentWord?.word != this.wordController?.text ||
        currentWord?.engDefinition != this.engDefController?.text ||
        currentWord?.lisuDefinition != lisuDefController?.text ||
        currentWord?.burmerDefinition != this.burmeseDefController?.text ||
        englishExamples != this.currentWord?.engExamples ||
        lisuExamples != this.currentWord?.lisuExamples ||
        burmeseExmaples != this.currentWord?.burmerExamples) {
      this.isChanged = true.obs;
      update();
    }
    {}
  }

  addOrUpdate() async {
    final word = Word(
      //
      userModel: Get.find<UserController>().currentUser,

      // may be user does wrong changes is verified is false
      //if user just click update and does't make changes keep as at as
      //else if new word keep unverified for initial
      isVerified: isUpdate == true && isChanged.value == true
          ? false
          : isUpdate == true && isChanged.value == false
              ? this.currentWord?.isVerified
              : false,
      word: wordController?.text,
      userId: Get.find<UserController>().currentUser?.id,

      engDefinition: engDefController?.text,
      lisuDefinition: lisuDefController?.text,
      burmerDefinition: burmeseDefController?.text,
      engExamples: <String>[
        engExample1Controller?.text ?? "",
        engExample2Controller?.text ?? ""
      ],
      lisuExamples: <String>[
        lisuExample1Controller?.text ?? "",
        lisuExample2Controller?.text ?? ""
      ],
      burmerExamples: <String>[
        burmeseExample1Controller?.text ?? "",
        burmeseExample2Controller?.text ?? ""
      ],
    );

    isUpdate == true
        ? await Get.find<FirestoreService>().updateWord(word, currentWord?.id)
        : await Get.find<FirestoreService>().addWord(word);
  }

  initFields(Word word) {
    //initilize current word
    currentWord = word;
    wordController?.text = word.word ?? "";
    engDefController?.text = word.engDefinition ?? "";
    lisuDefController?.text = word.lisuDefinition ?? "";

    burmeseDefController?.text = word.burmerDefinition ?? "";

    engDefController?.text = word.engDefinition ?? "";
    if (word.engExamples != null) {
      engExample1Controller?.text = word.engExamples![0];
      engExample2Controller?.text = word.engExamples![1];
    }
    if (word.burmerExamples != null) {
      burmeseExample1Controller?.text = word.burmerExamples![0];
      burmeseExample2Controller?.text = word.burmerExamples![1];
    }
    if (word.lisuExamples != null) {
      lisuExample1Controller?.text = word.lisuExamples![0];
      lisuExample2Controller?.text = word.lisuExamples![1];
    }
  }

  bool checkCheck() {
    return (engDefController?.text == "" &&
        lisuDefController?.text == "" &&
        burmeseDefController?.text == "");
  }
}
