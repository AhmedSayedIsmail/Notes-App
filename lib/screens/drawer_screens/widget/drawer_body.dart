import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/network/local/cach_helper.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/screens/auth_screens/login_screen/login_screen.dart';
import 'package:todo_application/screens/drawer_screens/drawer_screens.dart';
import 'package:todo_application/screens/drawer_screens/widget/user_image_name_widget.dart';
import 'package:todo_application/screens/setting_screen/setting_screen.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/todo_states.dart';
import 'package:todo_application/core/dummy_data.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    log("DrawerBody");
    return BlocConsumer<TodoCubit, TodoStates>(
      builder: (context, state) {
        if (TodoCubit.getCubit(context).currentUser != null) {
          return SafeArea(
            child: Container(
              color: TodoCubit.getCubit(context).currentUser!.userGender ==
                      Constants.kMale
                  ? ColorsTheme.manDrawerBackgroundColor
                  : ColorsTheme.womanDrawerBackgroundColor,
              padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UserImageNameWidget(),
                  _drawreListview(),
                  _drawerRowSettingAndLogOut(context)
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      listener: (context, state) {
        if (state is ScreenChanged) {
          context.goToAndKillLastWidget(routeName: DrawerScreens.id);
        }
        if (state is LogoutState) {
          CachHelper.removeData(key: Constants.cachUserToken).then((value) {
            currentPageIndex = 0;
            isLogOut = true;
            context.goToAndKillLastWidget(routeName: LoginScreen.id);
          });
        }
      },
    );
  }

  Row _drawerRowSettingAndLogOut(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.settings,
          color: Colors.white,
        ),
        customSizeBox(width: 10),
        GestureDetector(
          onTap: () {
            ///GO To Setting Screen
            context.gotoPushName(routeName: SettingScreen.id);
          },
          child: const Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        customSizeBox(width: 10),
        Container(
          width: 2,
          height: 20,
          color: Colors.white,
        ),
        customSizeBox(width: 10),
        InkWell(
          onTap: () {
            TodoCubit.getCubit(context).logOut();
          },
          child: const Text(
            'Log out',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _drawreListview() {
    return SizedBox(
      height: 150,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  TodoCubit.getCubit(context)
                      .selectScreen(selectedIndex: index, context: context);
                },
                child: Row(
                  children: [
                    currentPageIndex == index
                        ? Icon(
                            DummyData.drawerItems.elementAt(index)["icon"],
                            color: Colors.amber.withOpacity(0.5),
                            size: 25,
                          )
                        : Icon(
                            DummyData.drawerItems.elementAt(index)["icon"],
                            color: Colors.white.withOpacity(0.5),
                            size: 25,
                          ),
                    customSizeBox(
                      width: 25,
                    ),
                    currentPageIndex == index
                        ? Text(DummyData.drawerItems.elementAt(index)['title'],
                            style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))
                        : Text(DummyData.drawerItems.elementAt(index)['title'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, _) {
            return customSizeBox(height: 10);
          },
          itemCount: DummyData.drawerItems.length),
    );
  }
}
