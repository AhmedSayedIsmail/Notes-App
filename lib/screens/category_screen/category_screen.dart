import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_application/screens/category_screen/widget/user_category_list.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool notificationMessage = true;
  @override
  Widget build(BuildContext context) {
    log("CategoryScreen");
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          // color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
        ),
        child: SafeArea(
            child: Container(
                height: double.infinity,
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? ColorsTheme.manHomeBackgroundColor
                    : ColorsTheme.womanHomeBackgroundColor,
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _headerRow(context),
                      Divider(
                        thickness: 2,
                        color: TodoCubit.getCubit(context)
                                    .currentUser!
                                    .userGender ==
                                Constants.kMale
                            ? ColorsTheme.bluedarkColor
                            : ColorsTheme.womanFloatingpinkColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 25,
                              color: TodoCubit.getCubit(context)
                                          .currentUser!
                                          .userGender ==
                                      Constants.kMale
                                  ? ColorsTheme.blueColor
                                  : Colors.white),
                        ),
                      ),
                      customSizeBox(
                        height: 16,
                      ),
                      const UserCategoryList(),
                      customSizeBox(
                        height: 10,
                      ),
                    ],
                  ),
                )))));
  }

  Widget _headerRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isDrawerOpen
            ? iconWidget(
                icon: IconsAssets().assets[IconName.forwardarrow].toString(),
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? ColorsTheme.blueBlackColor
                    : Colors.white,
                onPress: () {
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    scaleFactor = 1;
                    isDrawerOpen = false;
                  });
                })
            : iconWidget(
                icon: IconsAssets().assets[IconName.menu].toString(),
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? ColorsTheme.blueBlackColor
                    : Colors.white,
                onPress: () {
                  setState(() {
                    xOffset = 230;
                    yOffset = 150;
                    scaleFactor = 0.6;
                    isDrawerOpen = true;
                  });
                }),
        Row(
          children: [
            iconWidget(
                icon: IconsAssets().assets[IconName.search].toString(),
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? ColorsTheme.blueBlackColor
                    : Colors.white,
                onPress: () {
                  //"Search Will Created Soon"
                }),
            notificationMessage
                ? Stack(
                    children: [
                      iconWidget(
                          icon: IconsAssets()
                              .assets[IconName.notification]
                              .toString(),
                          color: TodoCubit.getCubit(context)
                                      .currentUser!
                                      .userGender ==
                                  Constants.kMale
                              ? ColorsTheme.blueBlackColor
                              : Colors.white,
                          onPress: () {}),
                      Positioned(
                          top: 18,
                          right: 15,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                                color: ColorsTheme.redColor,
                                shape: BoxShape.circle),
                          ))
                    ],
                  )
                : iconWidget(
                    icon:
                        IconsAssets().assets[IconName.notification].toString(),
                    color:
                        TodoCubit.getCubit(context).currentUser!.userGender ==
                                Constants.kMale
                            ? ColorsTheme.blueBlackColor
                            : Colors.white,
                    onPress: () {
                      // "Notification Will Created Soon"
                    }),
          ],
        )
      ],
    );
  }
}
