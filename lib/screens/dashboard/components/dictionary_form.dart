
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/dictionary_form_controller.dart';
import 'package:lisudictionary_web/controllers/recent_controller.dart';
import 'package:lisudictionary_web/screens/dashboard/components/recent_files.dart';
import 'package:lisudictionary_web/screens/dashboard/components/textFields.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

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
                  width: constraints.maxWidth * 0.7,
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
                                              color: Color(0xFFEE2727))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TxtField(
                                          //text field controller for word field
                                          controller: controller.wordController,

                                          validator: (val) =>
                                              val == "" ? "Enter word" : null,

                                          labelText: "Word",
                                          hintText: "Enter word...",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: TxtField(
                                          labelText: "Definition",
                                          hintText: "Enter definition... ",
                                          controller:
                                              controller.engDefController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TxtField(
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
                                              color: const Color(0xFFEE2727))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TxtField(
                                    controller: controller.lisuDefController,
                                    validator: (val) => val == ""
                                        ? "*definition shouldn't be empty"
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
                                            color: const Color(0xFFEE2727)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TxtField(
                                    controller: controller.burmeseDefController,
                                    validator: (val) =>
                                        val == "" ? "*required" : null,
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
                                      showDialog(context: context, builder: (_){

                                        return Lottie.asset("assets/lottie/loader.json",width: Get.width*0.2);
                                      }
                                      );
                                      if (controller.formKey?.currentState
                                              ?.validate() ??
                                          false) {
                                        controller.formKey?.currentState
                                            ?.save();
                                        //if is update is true update word else add new word

                                      await  controller.addOrUpdate();
                                      Get.back();




                                      }
                                      Get.back();
                                    },
                                    //  icon: Icon(Icons.add),
                                    child:controller.isUpdate==true?Text("UPDATE"): Text("SUBMIT"),
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
