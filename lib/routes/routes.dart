import 'package:flutter/material.dart';
import 'package:todo_application/screens/add_tesk_screen/add_task_screen.dart';
import 'package:todo_application/screens/auth_screens/login_screen/login_screen.dart';
import 'package:todo_application/screens/auth_screens/register_screen/register_screen.dart';
import 'package:todo_application/screens/drawer_screens/drawer_screens.dart';
import 'package:todo_application/screens/home_screen/home_screen.dart';
import 'package:todo_application/screens/onboarding_screen/onboarding_screen.dart';
import 'package:todo_application/screens/setting_screen/setting_screen.dart';
import 'package:todo_application/screens/splash_screen/splash_screen.dart';

extension NavigateTo on BuildContext {
  goTo(pageView) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => pageView));
  }

  goBack() {
    Navigator.pop(this);
  }

  gotoPushName({required String routeName}) {
    Navigator.pushNamed(this, routeName);
  }

  goToAndKillLastWidget({required String routeName}) {
    Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  }
}

Route<MaterialPageRoute<dynamic>> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.id:
      return MaterialPageRoute(builder: (context) => const OnBoardingScreen());

    case LoginScreen.id:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case RegisterScreen.id:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());

    case HomeScreen.id:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case DrawerScreens.id:
      return MaterialPageRoute(builder: (context) => const DrawerScreens());

    case AddTaskScreen.id:
      return MaterialPageRoute(builder: (context) => const AddTaskScreen());

    case SettingScreen.id:
      return MaterialPageRoute(builder: (context) => const SettingScreen());

    default:
      //this is the first Page When app opened
      return MaterialPageRoute(builder: (context) => const SplashScreen());
  }
}
