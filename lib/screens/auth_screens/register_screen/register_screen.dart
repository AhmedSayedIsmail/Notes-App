import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/models/user_model.dart';
import 'package:todo_application/network/local/cach_helper.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/screens/auth_screens/widgets/custom_form.dart';
import 'package:todo_application/screens/drawer_screens/drawer_screens.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/todo_states.dart';
import 'package:todo_application/core/images_assets.dart';
import 'package:todo_application/core/widgets/custom_checkbox.dart';
import 'package:todo_application/core/widgets/custom_radio_button.dart';
import 'package:todo_application/core/widgets/custom_round_button.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = "Register";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    log("R");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register Screen"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: BlocConsumer<TodoCubit, TodoStates>(
          builder: (context, state) {
            var todoCubit = TodoCubit.getCubit(context);
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Image(
                          width: 50,
                          height: 50,
                          image: AssetImage(
                            ImagesAssets()
                                .assets[AssetName.logoImage]
                                .toString(),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: ColorsTheme.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        Constants.kSignupText,
                        style: TextStyle(
                          color: ColorsTheme.blackColor,
                          fontSize: 16,
                        ),
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
                      CustomRadioButton(
                        gender: todoCubit.userGender,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomCheckBox(
                        isChecked: todoCubit.isChecked,
                        onChanged: (value) {
                          todoCubit.updateCheckBox(isChecked: value!);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      state is LoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomRoundButton(
                              text: 'Register',
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  todoCubit.addUser(
                                      userModel: UserModel(
                                          userId: generateRandomString(len: 8),
                                          userName: todoCubit.userName,
                                          userPassword: todoCubit.userPassword,
                                          userGender: todoCubit.userGender),
                                      context: context);
                                }
                              },
                              buttonColor: ColorsTheme.blueColor,
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (BuildContext context, TodoStates state) {
            if (state is AddUserFauild) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is AddUserSuccessfully) {
              CachHelper.saveData(key: Constants.cachUserToken, value: token)
                  .then((value) {
                TodoCubit.getCubit(context).readCurrentUserData();
              });
            }
            if (state is RegisterReadUserSuccessfully) {
              if (isLogOut) {
                ReadDataCubit.getCubit(context).readUserCategoies();
                ReadDataCubit.getCubit(context).readUserTasks();
                isLogOut = false;
              }
              context.goToAndKillLastWidget(routeName: DrawerScreens.id);
            }
          },
        ));
  }
}
