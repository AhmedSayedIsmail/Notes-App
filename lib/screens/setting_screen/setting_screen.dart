import 'package:flutter/material.dart';
import 'package:todo_application/screens/setting_screen/widget/custom_cards.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/images_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class SettingScreen extends StatelessWidget {
  static const String id = "SettingScreen";
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconWidget(
                  icon: IconsAssets().assets[IconName.backarrow].toString(),
                  onPress: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black),
              Row(
                children: [
                  iconWidget(
                    icon: IconsAssets().assets[IconName.noti].toString(),
                    onPress: () {},
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          TodoCubit.getCubit(context).currentUser!.userGender ==
                                  Constants.kMale
                              ? AssetImage(ImagesAssets()
                                  .assets[AssetName.manProfile2]
                                  .toString())
                              : AssetImage(ImagesAssets()
                                  .assets[AssetName.womanProfile2]
                                  .toString()),
                    ),
                  ),
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              "Settings",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorsTheme.bluedarkColor),
            ),
          ),
          Center(
            child: Image(
              image: AssetImage(
                  ImagesAssets().assets[AssetName.settingImage].toString()),
              width: 210,
            ),
          ),
          customSizeBox(height: 15),
          const CustomCards(),
        ],
      ),
    )));
  }
}
