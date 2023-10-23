import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_application/network/local/cach_helper.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/screens/auth_screens/login_screen/login_screen.dart';
import 'package:todo_application/screens/drawer_screens/drawer_screens.dart';
import 'package:todo_application/screens/onboarding_screen/onboarding_screen.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/images_assets.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    var onBoarding = CachHelper.getBoolean(key: Constants.cachOnBoradingKey);
    token = CachHelper.getString(key: Constants.cachUserToken);
    String statewidget = "";
    if (onBoarding != null) {
      if (token != null) {
        TodoCubit.getCubit(context).readCurrentUserData();
        statewidget = DrawerScreens.id;
      } else {
        statewidget = LoginScreen.id;
      }
    } else {
      statewidget = OnBoardingScreen.id;
    }
    Future.delayed(const Duration(seconds: 5), () {
      context.goToAndKillLastWidget(routeName: statewidget);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
            image: AssetImage(
          ImagesAssets().assets[AssetName.logoImage].toString(),
        )),
        const SizedBox(
          height: 25,
        ),
        Center(
          child: Text(
            'TODO',
            style: TextStyle(fontSize: 45, color: Colors.red.shade700),
          ),
        ),
      ],
    ));
  }
}
