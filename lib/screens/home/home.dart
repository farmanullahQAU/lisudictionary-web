import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/constants.dart';
import 'package:lisudictionary_web/controllers/MenuController.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/models/user_model.dart';
import 'package:lisudictionary_web/screens/dashboard/dashboard_screen.dart';
import 'package:lisudictionary_web/screens/register/register_contributor_view.dart';

import '../../responsive.dart';
import '../components/side_menu.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: bgColor,
          body: FutureBuilder(
              future: controller.getCurrentUser(),
              builder: (context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.hasData)
                  return Scaffold(
                    drawer: SideMenu(),
                    backgroundColor: bgColor,
                    floatingActionButton: snapshot.data?.isAdmin == true
                        ? FloatingActionButton(
                            child: Icon(Icons.person_add),
                            onPressed: () {
                              Get.toNamed("/register");
                            },
                          )
                        : Container(),
                    key: Get.find<MenuController>().scaffoldKey,
                    body: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // We want this side menu only for large screen
                        if (Responsive.isDesktop(context))
                          Expanded(
                            // default flex = 1
                            // and it takes 1/6 part of the screen
                            child: SideMenu(),
                          ),
                        Expanded(
                          // It takes 5/6 part of the screen
                          flex: 5,
                          child: DashboardScreen(),
                        ),
                      ],
                    ),
                  );

                if (snapshot.hasError)
                  return Center(child: Text("Something went wrong"));
                return LinearProgressIndicator();
              }),
        );
      },
    );
  }
}
