import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/network/local/cach_helper.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/screens/auth_screens/register_screen/register_screen.dart';
import 'package:todo_application/screens/auth_screens/widgets/custom_form.dart';
import 'package:todo_application/screens/drawer_screens/drawer_screens.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/todo_states.dart';
import 'package:todo_application/core/images_assets.dart';
import 'package:todo_application/core/widgets/custom_round_button.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "LoginScreen";
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    log("L");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Screen"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: BlocConsumer<TodoCubit, TodoStates>(
          listener: (context, state) {
            if (state is LoginUserFauild) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is LoginUserSuccessfully) {
              CachHelper.saveData(key: Constants.cachUserToken, value: token);
              TodoCubit.getCubit(context).readCurrentUserData();
            }
            if (state is LoginReadUserSuccessfully) {
              if (isLogOut) {
                ReadDataCubit.getCubit(context).readUserCategoies();
                ReadDataCubit.getCubit(context).readUserTasks();
                isLogOut = false;
              }
              context.goToAndKillLastWidget(routeName: DrawerScreens.id);
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    _buildLogo(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(fontSize: 35),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Sign in to continue...",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomForm(
                      formkey: formKey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    state is LoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomRoundButton(
                            text: 'Login',
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                TodoCubit.getCubit(context)
                                    .loginUser(context: context);
                              }
                            },
                            buttonColor: ColorsTheme.blueColor,
                          ),
                    const SizedBox(height: 15),
                    _buildRegisterRow(context),
                  ]),
                ),
              ),
            ));
          },
        ));
  }

  Widget _buildLogo() => Row(
        children: [
          Image(
            image: AssetImage(
              ImagesAssets().assets[AssetName.logoImage].toString(),
            ),
            width: 25,
            height: 25,
          ),
          const Text(
            "ToDo App",
            style: TextStyle(color: ColorsTheme.redColor, fontSize: 30),
          ),
        ],
      );

  Widget _buildRegisterRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            Constants.havenotaccount,
            style: TextStyle(color: ColorsTheme.blackColor, fontSize: 18),
          ),
          TextButton(
            child: const Text(
              "\tSIGN UP",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorsTheme.redColor),
            ),
            onPressed: () {
              context.gotoPushName(routeName: RegisterScreen.id);
            },
          ),
        ],
      );
}
