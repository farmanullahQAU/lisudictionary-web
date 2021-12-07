import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/screens/components/textFields.dart';
import 'package:lisudictionary_web/screens/dictionary_form/dictionary_form_controller.dart';
import 'package:lisudictionary_web/controllers/allwords_controller.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import '../../responsive.dart';

class DictionarForm extends StatelessWidget {
  const DictionarForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DictFormController>(
      builder: (controller) => LayoutBuilder(
        builder: (context, constraints) => Scaffold(
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: Responsive.isMobile(context)
                      ? constraints.maxWidth * 0.99
                      : constraints.maxWidth * 0.7,
                  child: Card(
                    color: secondaryColor,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("English",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TxtField(
                                    maxLength: 100,
                                    //text field controller for word field
                                    controller: controller.wordController,

                                    validator: (val) =>
                                        val == "" ? "Enter word" : null,

                                    labelText: "Word",
                                    hintText: "Enter word...",
                                  ),
                                  TxtField(
                                    maxLength: 500,
                                    maxLines: 4,
                                    labelText: "Definition",
                                    hintText: "Enter definition... ",
                                    controller: controller.engDefController,
                                    validator: (val) => (controller
                                                        .engExample1Controller
                                                        ?.text !=
                                                    "" ||
                                                controller.engExample2Controller
                                                        ?.text !=
                                                    "") &&
                                            val == ""
                                        ? "*definition required"
                                        : null,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TxtField(
                                      maxLines: 4,
                                      maxLength: 500,
                                      labelText: "Example 1",
                                      hintText: "Enter example 1",
                                      controller:
                                          controller.engExample1Controller,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: TxtField(
                                      maxLines: 4,
                                      maxLength: 500,
                                      controller:
                                          controller.engExample2Controller,
                                      labelText: "Example 2",
                                      hintText: "Enter example 2",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Lius",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TxtField(
                                    maxLines: 4,
                                    controller: controller.lisuDefController,
                                    validator: (val) => (controller
                                                        .lisuExample1Controller
                                                        ?.text !=
                                                    "" ||
                                                controller
                                                        .lisuExample2Controller
                                                        ?.text !=
                                                    "") &&
                                            val == ""
                                        ? "*required"
                                        : null,
                                    labelText: "Definition",
                                    hintText: "Definition in lisu...",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TxtField(
                                      maxLines: 4,
                                      controller:
                                          controller.lisuExample1Controller,
                                      labelText: "Example 1",
                                      hintText: "Enter example 1",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: TxtField(
                                      maxLines: 4,
                                      labelText: "Example 2",
                                      hintText: "Enter example 2",
                                      controller:
                                          controller.lisuExample2Controller,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Burmese",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.cyan),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TxtField(
                                    maxLines: 4,
                                    controller: controller.burmeseDefController,
                                    validator: (val) => (controller
                                                        .burmeseExample1Controller
                                                        ?.text !=
                                                    "" ||
                                                controller
                                                        .burmeseExample2Controller
                                                        ?.text !=
                                                    "") &&
                                            val == ""
                                        ? "*required"
                                        : null,
                                    labelText: "Definition",
                                    hintText: "Definition in burmese...",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TxtField(
                                      maxLines: 4,
                                      controller:
                                          controller.burmeseExample1Controller,
                                      labelText: "Example 1",
                                      hintText: "Enter example 1",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: TxtField(
                                      maxLines: 4,
                                      labelText: "Example 2",
                                      hintText: "Enter example 2",
                                      controller:
                                          controller.burmeseExample2Controller,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: constraints.maxWidth * 0.2,
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 1.5,
                                        vertical: defaultPadding /
                                            (Responsive.isMobile(context)
                                                ? 2
                                                : 1),
                                      ),
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Lottie.asset(
                                                "assets/lottie/loader.json",
                                                width: Get.width * 0.2);
                                          });

                                      if (controller.checkCheck()) {
                                        Get.back();
                                        return Get.defaultDialog(
                                            radius: 5,
                                            title: "Note!",
                                            middleText:
                                                "Please enter details in at least one language.");
                                      }

                                      if (controller.formKey?.currentState
                                              ?.validate() ??
                                          false) {
                                        controller.formKey?.currentState
                                            ?.save();
                                        if (await Get.find<FirestoreService>()
                                                .isExist(controller
                                                    .wordController?.text) &&
                                            controller.isUpdate == false) {
                                          BotToast.showText(
                                              text: "Word Already Exists",
                                              contentColor: Colors.red,
                                              align: Alignment.center);
                                        }

                                        //if is update is true update word else add new word
                                        else {
                                          controller.checkChanges();
                                          await controller.addOrUpdate();
                                          Get.find<RecentController>().update();
                                          Get.back();
                                          Get.back();
                                        }
                                      }
                                      Get.back();
                                    },
                                    //  icon: Icon(Icons.add),
                                    child: controller.isUpdate == true
                                        ? Text("UPDATE")
                                        : Text("SUBMIT"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: RichText(
                  text: TextSpan(
                    text: 'Add new word to ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.white54),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Lisu Dictionary',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Color(0xFFFFCF26))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
