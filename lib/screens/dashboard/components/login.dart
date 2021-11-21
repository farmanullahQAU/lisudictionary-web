import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/screens/dashboard/components/textFields.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import 'loader.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
   LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginRegisterController>(
      builder: (controller) => LayoutBuilder(
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
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        DefaultTabController(
                          length: 2,
                          child: TabBar(
                            onTap: (index) {
                              controller.changeIndex(index);
                            },
                            tabs: [
                              Tab(
                                child: Text("SIGNIN"),
                              ),
                              Tab(child: Text("SIGNUP")),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        controller.loginRegister
                            .elementAt(controller.currentIndex.value),
                      ],
                    ),
                  ),
                  Container(
                    width: Responsive.isDesktop(context)
                        ? constraints.maxWidth * 0.4
                        : Responsive.isTablet(context)
                            ? constraints.maxWidth * 0.5
                            : constraints.maxWidth * 98,
                    height: 10,
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
      ),
    );
  }
}

class LoginForm extends StatelessWidget {

  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Get.find<LoginRegisterController>().loginKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TxtField(
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TxtField(
              controller: Get.find<LoginRegisterController>().passwordController,

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
                  BotToast.showLoading();

                  if(Get.find<LoginRegisterController>().registerKey.currentState?.validate()??false)
                  {
                    Get.find<LoginRegisterController>().registerKey.currentState?.save();
                  }
                  //register user;

                  await  Get.find<LoginRegisterController>().loginUser();
                  //close loader if successful
                  BotToast.closeAllLoading();
                },
                child: Text("LOGIN"),

                //  icon: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {

  RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Get.find<LoginRegisterController>().registerKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TxtField(
              controller:Get.find<LoginRegisterController>().nameController ,

              validator: (val) => val == "" ? "*enter name" : null,
              isOutlined: true,
              labelText: "Name",
              hintText: "Enter your name... ",

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TxtField(
              isOutlined: true,
               controller:Get.find<LoginRegisterController>().emailController ,

              validator: (val) => val == "" ? "*enter email" : null,

              labelText: "Email",
              hintText: "Enter email...",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TxtField(
              controller:Get.find<LoginRegisterController>().passwordController ,

              isOutlined: true,


              validator: (val) => val == "" ? "*password" : null,

              labelText: "Password",
              hintText: "Enter password...",
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
                  BotToast.showLoading();

                  if(Get.find<LoginRegisterController>().registerKey.currentState?.validate()??false)
                    {
                      Get.find<LoginRegisterController>().registerKey.currentState?.save();
                    }
               //register user;
                await  Get.find<LoginRegisterController>().registerUser();
                  //close loader if successful
                BotToast.closeAllLoading();


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
