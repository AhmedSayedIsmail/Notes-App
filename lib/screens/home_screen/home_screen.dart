import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/screens/add_tesk_screen/add_task_screen.dart';
import 'package:todo_application/screens/home_screen/widgets/categories_list_view.dart';
import 'package:todo_application/screens/home_screen/widgets/tasks_list_view.dart';
import 'package:todo_application/screens/home_screen/widgets/user_name_widget.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;
  bool notificationMessage = true;

  @override
  Widget build(BuildContext context) {
    log("HomeScreen");
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
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerRow(context),
                customSizeBox(
                  height: 15,
                ),
                const UserNameWidget(),
                customSizeBox(
                  height: 15,
                ),
                _text(
                  text: Constants.kCategoriesText,
                ),
                customSizeBox(
                  height: 15,
                ),
                const Expanded(child: CategoriesListView()),
                customSizeBox(
                  height: 15,
                ),
                _text(text: Constants.kTodaytasksText),
                customSizeBox(
                  height: 15,
                ),
                const Expanded(flex: 2, child: TasksListView())
              ],
            ),
            _customFloatingActionButton(context),
          ]),
        )));
  }

  Align _customFloatingActionButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: FloatingActionButton(
          backgroundColor:
              TodoCubit.getCubit(context).currentUser!.userGender ==
                      Constants.kMale
                  ? ColorsTheme.manFloatingblueColor
                  : ColorsTheme.womanFloatingpinkColor,
          onPressed: () {
            context.gotoPushName(routeName: AddTaskScreen.id);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _text({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
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
