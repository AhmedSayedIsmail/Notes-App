import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/images_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool notificationMessage = true;

  @override
  Widget build(BuildContext context) {
    log("P");
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          // color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
        ),
        child: Scaffold(
          backgroundColor:
              TodoCubit.getCubit(context).currentUser!.userGender ==
                      Constants.kMale
                  ? ColorsTheme.manHomeBackgroundColor
                  : ColorsTheme.womanHomeBackgroundColor,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? AssetImage(
                        ImagesAssets().assets[AssetName.manProfile].toString())
                    : AssetImage(ImagesAssets()
                        .assets[AssetName.womanProfile]
                        .toString()),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDrawerOpen
                            ? iconWidget(
                                icon: IconsAssets()
                                    .assets[IconName.forwardarrow]
                                    .toString(),
                                onPress: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                },
                                color: Colors.white)
                            : iconWidget(
                                icon: IconsAssets()
                                    .assets[IconName.menu]
                                    .toString(),
                                onPress: () {
                                  setState(() {
                                    xOffset = 230;
                                    yOffset = 150;
                                    scaleFactor = 0.6;
                                    isDrawerOpen = true;
                                  });
                                },
                                color: Colors.white)
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .5,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 7, 21, 56),
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(330))),
                    ),
                  ],
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * .5 -
                        (MediaQuery.of(context).size.width * .1),
                    left: MediaQuery.of(context).size.width * .4,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 6, color: Colors.white),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: TodoCubit.getCubit(context)
                                          .currentUser!
                                          .userGender ==
                                      Constants.kMale
                                  ? AssetImage(ImagesAssets()
                                      .assets[AssetName.manProfile2]
                                      .toString())
                                  : AssetImage(ImagesAssets()
                                      .assets[AssetName.womanProfile2]
                                      .toString()))),
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.width * .7),
                    left: MediaQuery.of(context).size.width * .4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          TodoCubit.getCubit(context).currentUser!.userName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                      ),
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.width * .7),
                    right: MediaQuery.of(context).size.width * .02,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 6, color: Colors.white),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/noti.png"))),
                    )),
                notificationMessage
                    ? Positioned(
                        top: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.width * .68),
                        right: MediaQuery.of(context).size.width * .05,
                        child: Container(
                          width: 15,
                          height: 12,
                          decoration: const BoxDecoration(
                              color: ColorsTheme.redColor,
                              shape: BoxShape.circle),
                        ))
                    : Container(),
                Positioned(
                  top: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.width * .4),
                  left: MediaQuery.of(context).size.width * .3,
                  child: const Text("Sex",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.width * .3),
                  left: MediaQuery.of(context).size.width * .3,
                  child: Text(
                      TodoCubit.getCubit(context).currentUser!.userGender,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.amber)),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.width * .4),
                  right: MediaQuery.of(context).size.width * .1,
                  child: const Text("Total Tasks",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.width * .3),
                  right: MediaQuery.of(context).size.width * .20,
                  child: Text(
                      "${ReadDataCubit.getCubit(context).userTasksList.length}",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.amber)),
                ),
              ]),
            ),
          ),
        ));
  }
}
