import 'package:flutter/material.dart';
import 'package:lisudictionary_web/screens/components/header.dart';
import 'package:lisudictionary_web/screens/components/recent_files.dart';

import '../../constants.dart';
import '../../responsive.dart';
import '../components/my_fields.dart';

//add mobile or desktop view
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      WordsTable(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
