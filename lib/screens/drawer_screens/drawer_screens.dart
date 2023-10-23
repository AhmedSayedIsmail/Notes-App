import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_application/screens/drawer_screens/widget/drawer_body.dart';
import 'package:todo_application/core/components.dart';

class DrawerScreens extends StatelessWidget {
  static const String id = "DrawerScreens";

  const DrawerScreens({super.key});

  @override
  Widget build(BuildContext context) {
    log("DrawerScreens");
    return Scaffold(
      body:
          Stack(children: [const DrawerBody(), listScreens[currentPageIndex]]),
      // body: DrawerBody(),
    );
  }
}
