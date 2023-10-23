import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/network/local/cach_helper.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:todo_application/core/controllers/write_data_cubit/write_data_states.dart';
import 'package:todo_application/core/widgets/custom_round_button.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';
import 'package:todo_application/screens/auth_screens/login_screen/login_screen.dart';

class WarningDialogWidget extends StatelessWidget {
  const WarningDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WriteDataCubit(),
      child: BlocConsumer<WriteDataCubit, WriteDataStates>(
        listener: (context, state) {
          if (state is DeleteUserSuccessfully) {
            context.goBack();
            CachHelper.removeData(key: Constants.cachUserToken).then((value) {
              currentPageIndex = 0;
              TodoCubit.getCubit(context).readUsersData();
              isLogOut = true;
              context.goToAndKillLastWidget(routeName: LoginScreen.id);
            });
          }
        },
        builder: (context, state) {
          return Dialog(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color:
                        TodoCubit.getCubit(context).currentUser!.userGender ==
                                Constants.kMale
                            ? ColorsTheme.manHomeBackgroundColor
                            : ColorsTheme.womanHomeBackgroundColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.warning_sharp,
                          color: ColorsTheme.yellowColor,
                          size: 50,
                        ),
                        Text(
                          "Are You Sure To Delete This User",
                          style: TextStyle(
                              color: TodoCubit.getCubit(context)
                                          .currentUser!
                                          .userGender ==
                                      Constants.kMale
                                  ? ColorsTheme.redColor1
                                  : ColorsTheme.blueWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    customSizeBox(height: 20),
                    state is WriteLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomRoundButton(
                                  text: 'Cancel',
                                  width: 120,
                                  onPress: () {
                                    context.goBack();
                                  },
                                  buttonColor: Colors.green),
                              CustomRoundButton(
                                  text: 'Delete',
                                  width: 120,
                                  onPress: () {
                                    WriteDataCubit.getCubit(context)
                                        .deleteUserData();
                                  },
                                  buttonColor: Colors.red),
                            ],
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
