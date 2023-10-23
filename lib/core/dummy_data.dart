import 'package:flutter/material.dart';
import 'package:todo_application/models/category_model.dart';
import 'package:todo_application/models/onboarding_item.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/images_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class DummyData {
  static const List<Map> drawerItems = [
    {'icon': Icons.house_outlined, 'title': 'Home'},
    {'icon': Icons.category, 'title': 'Categories'},
    {'icon': Icons.person, 'title': 'Profile'},
  ];
  static const List<int> remindList = [5, 10, 15, 20];
  static const List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  List<OnBoardingItem> onBoardingItems = [
    OnBoardingItem(
        image: ImagesAssets().assets[AssetName.onboardingOne].toString(),
        title: 'Manage Your Task',
        body:
            'With This Small App You Can Orgnize All Your Tasks and Duties In A One Single App.'),
    OnBoardingItem(
        image: ImagesAssets().assets[AssetName.onboardingTwo].toString(),
        title: 'Plan Your Day',
        body: 'Add A Task And The App Will Remind You.'),
    OnBoardingItem(
        image: ImagesAssets().assets[AssetName.onboardingThree].toString(),
        title: 'Accomplish Your Goals ',
        body: 'Track Your Activities And Accomplish Your Goals.'),
  ];
  List<Map<String, dynamic>> categoryItems = [
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.work].toString(),
      categorytype: "Work",
      firstColor: ColorsTheme.workcolor1,
      secondColor: ColorsTheme.workcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.health].toString(),
      categorytype: "Health",
      firstColor: ColorsTheme.healthcolor1,
      secondColor: ColorsTheme.healthcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.vacation].toString(),
      categorytype: "Vacation",
      firstColor: ColorsTheme.vacationcolor1,
      secondColor: ColorsTheme.vacationcolor2,
    ).toJson(),
    CategoryModel(
            categoryid: generateRandomInteger(),
            categoryimage: IconsAssets().assets[IconName.gift].toString(),
            categorytype: "Gift")
        .toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.meeting].toString(),
      categorytype: "Meeting",
      firstColor: ColorsTheme.meetingcolor1,
      secondColor: ColorsTheme.meetingcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.ideas].toString(),
      categorytype: "Ideas",
      firstColor: ColorsTheme.ideacolor1,
      secondColor: ColorsTheme.ideacolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.fastfood].toString(),
      categorytype: "Fast Food",
      firstColor: ColorsTheme.fastfoodcolor1,
      secondColor: ColorsTheme.fastfoodcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.cooking].toString(),
      categorytype: "Cooking",
      firstColor: ColorsTheme.cookingcolor1,
      secondColor: ColorsTheme.cookingcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.footballMatch].toString(),
      categorytype: "Sport Match",
      firstColor: ColorsTheme.sportcolor1,
      secondColor: ColorsTheme.sportcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.payment].toString(),
      categorytype: "Payment",
      firstColor: ColorsTheme.paymentcolor1,
      secondColor: ColorsTheme.paymentcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.car].toString(),
      categorytype: "Car",
      firstColor: ColorsTheme.carcolor1,
      secondColor: ColorsTheme.carcolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.party].toString(),
      categorytype: "Party",
      firstColor: ColorsTheme.partycolor1,
      secondColor: ColorsTheme.partycolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.music].toString(),
      categorytype: "Musics",
      firstColor: ColorsTheme.musiccolor1,
      secondColor: ColorsTheme.musiccolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.movie].toString(),
      categorytype: "Movies",
      firstColor: ColorsTheme.moviescolor1,
      secondColor: ColorsTheme.moviescolor2,
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.shopping].toString(),
      categorytype: "Shopping",
    ).toJson(),
    CategoryModel(
      categoryid: generateRandomInteger(),
      categoryimage: IconsAssets().assets[IconName.airplan].toString(),
      categorytype: "AiroPlan",
      firstColor: ColorsTheme.airplancolor1,
      secondColor: ColorsTheme.airplancolor2,
    ).toJson(),
  ];
}
