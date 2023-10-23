import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_application/models/onboarding_item.dart';
import 'package:todo_application/network/database/sql_database.dart';
import 'package:todo_application/network/local/cach_helper.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/dummy_data.dart';
import 'package:todo_application/core/sql_constants.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';
import 'package:todo_application/screens/auth_screens/login_screen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'OnBoarding';

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  @override
  void initState() {
    for (int index = 0; index < DummyData().categoryItems.length; index++) {
      SqlDb().insertDataBase(
          tableName: SqlConstants.tableCategory,
          data: DummyData().categoryItems[index]);
      log("number $index  inserted");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Build");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  _submit(context);
                },
                child: const Text(
                  Constants.skipText,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorsTheme.redColor),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (index) {
                    if (index == DummyData().onBoardingItems.length - 1) {
                      isLast = !isLast;
                    } else {
                      isLast = false;
                    }
                    log("$isLast");
                  },
                  itemBuilder: (context, index) =>
                      _buildBoardingItem(DummyData().onBoardingItems[index]),
                  itemCount: DummyData().onBoardingItems.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: DummyData().onBoardingItems.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: ColorsTheme.blueWhiteColor,
                      activeDotColor: ColorsTheme.redColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: ColorsTheme.redColor,
                    onPressed: () {
                      if (isLast) {
                        _submit(context);
                      } else {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _submit(BuildContext context) {
    CachHelper.saveData(key: Constants.cachOnBoradingKey, value: true)
        .then((value) {
      context.goToAndKillLastWidget(routeName: LoginScreen.id);
    });
  }

  Widget _buildBoardingItem(OnBoardingItem item) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(child: Image(image: AssetImage(item.image))),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              item.title,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              item.body,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      );
}
