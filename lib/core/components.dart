import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_application/screens/category_screen/category_screen.dart';
import 'package:todo_application/screens/home_screen/home_screen.dart';
import 'package:todo_application/screens/profile_screen/profile_screen.dart';

String? token;
bool isLogOut = false;
List<Widget> listScreens = [
  const HomeScreen(),
  const CategoryScreen(),
  const ProfileScreen()
];
int currentPageIndex = 0;
String generateRandomString({required int len}) {
  var r = Random();
  const char = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => char[r.nextInt(char.length)]).join();
}

int generateRandomInteger() {
  var r = Random();
  return r.nextInt(1000);
}

String dateTimeFormat(DateTime? date) {
  return date == null || date == DateTime(0)
      ? ""
      : "${date.day.toString().padLeft(2)} / ${date.month.toString().padLeft(2)} / ${date.year}";
}

Widget customSizeBox({double? width, double? height}) => SizedBox(
      width: width,
      height: height,
    );

Widget iconWidget(
    {required String icon, required Function()? onPress, Color? color}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: IconButton(
        onPressed: onPress,
        icon: SvgPicture.asset(
          icon,
          color: color,
          width: 25,
          height: 25,
        )),
  );
}

Widget svgAsset({height, width, assetName, color}) => SizedBox(
      height: height,
      width: width,
      child: SvgPicture.asset(assetName, fit: BoxFit.cover, color: color),
    );
