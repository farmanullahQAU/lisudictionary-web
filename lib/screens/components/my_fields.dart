import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/screens/dictionary_form/dictionary_form_controller.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

//adds words added text and contribute word button
class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Words Added",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Get.find<DictFormController>().isUpdate = false;
                Get.find<DictFormController>().clearFields();

                Navigator.pushNamed(context, "/wordsform");

                // Navigator.push(context, MaterialPageRoute(builder: (_)=>DictionarForm()));
              },
              icon: Icon(Icons.comment),
              label: const Text("Contribute"),
            )
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
