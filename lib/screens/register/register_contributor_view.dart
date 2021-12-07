import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/screens/components/textFields.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants.dart';
import '../../../../responsive.dart';
import '../login/login_controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Container(
            width: Responsive.isDesktop(context)
                ? constraints.maxWidth * 0.4
                : Responsive.isTablet(context)
                    ? constraints.maxWidth * 0.5
                    : constraints.maxWidth * 98,
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 60,
                      // ),
                      // Text("SIGNIN"),
                      SizedBox(
                        height: 60,
                      ),
                      SignUpForm(),
                    ],
                  ),
                ),
                Container(
                  width: Responsive.isDesktop(context)
                      ? constraints.maxWidth * 0.4
                      : Responsive.isTablet(context)
                          ? constraints.maxWidth * 0.5
                          : constraints.maxWidth * 98,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Get.find<LoginRegisterController>().loginKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TxtField(
              isLimit: false,
              controller: Get.find<LoginRegisterController>().nameController,
              isOutlined: true,
              //text field controller for word field
              //  controller: controller.wordController,

              validator: (val) => val == "" ? "Enter name" : null,

              labelText: "Name",
              hintText: "Enter name...",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TxtField(
              isLimit: false,
              controller: Get.find<LoginRegisterController>().emailController,
              isOutlined: true,
              //text field controller for word field
              //  controller: controller.wordController,

              validator: (val) => val == "" ? "Enter email" : null,

              labelText: "Email",
              hintText: "Enter Email...",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TxtField(
              maxLength: 15,
              controller:
                  Get.find<LoginRegisterController>().passwordController,

              validator: (val) => val == "" ? "Enter password" : null,
              isOutlined: true,
              labelText: "Password",
              hintText: "Enter password... ",
              //    controller:
              //   controller.engDefController,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () async {
                  if (Get.find<LoginRegisterController>()
                          .loginKey
                          .currentState
                          ?.validate() ??
                      false) {
                    Get.find<LoginRegisterController>()
                        .loginKey
                        .currentState
                        ?.save();
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Lottie.asset("assets/lottie/loader.json",
                              width: Get.width * 0.2);
                        });
                    await Get.find<LoginRegisterController>().registerUser();
                    Get.back();
                  }
                  //register user;

                  //close loader if successful
                },
                child: Text("REGISTER"),

                //  icon: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
