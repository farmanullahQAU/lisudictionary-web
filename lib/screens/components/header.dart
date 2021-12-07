import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/MenuController.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: Get.find<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        ProfileCard()
      ],
    );
  }
}

//add admin or contributor name and role card
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Image.asset(
          //   "assets/images/profile_pic.png",
          //   height: 38,
          // ),
          CircleAvatar(
            child: Icon(Icons.person),
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Get.find<UserController>().currentUser != null
                  ? Column(
                      children: [
                        Text(
                            Get.find<UserController>().currentUser?.name ?? ""),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 10,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Get.find<UserController>().isAdmin() == true
                                ? Text(
                                    "Admin",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            fontSize: 10, color: Colors.cyan),
                                  )
                                : Text("Contributor",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(fontSize: 10))
                          ],
                        ),
                      ],
                    )
                  : Text("..."),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
