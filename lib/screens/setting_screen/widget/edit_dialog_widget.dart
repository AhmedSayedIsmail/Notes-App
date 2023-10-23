import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/core/widgets/custom_text_form_field.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:todo_application/core/controllers/write_data_cubit/write_data_states.dart';
import 'package:todo_application/core/widgets/custom_round_button.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class EditDialogWidget extends StatefulWidget {
  final bool isName;

  const EditDialogWidget({
    super.key,
    this.isName = false,
  });

  @override
  State<EditDialogWidget> createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WriteDataCubit(),
      child: BlocConsumer<WriteDataCubit, WriteDataStates>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccessfully) {
            TodoCubit.getCubit(context).readCurrentUserData();
            TodoCubit.getCubit(context).readUsersData();
            context.goBack();
          }
        },
        builder: (context, state) {
          return Dialog(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: TodoCubit.getCubit(context).currentUser!.userGender ==
                            Constants.kMale
                        ? ColorsTheme.manHomeBackgroundColor
                        : ColorsTheme.womanHomeBackgroundColor,
                    borderRadius: BorderRadius.circular(15)),
                child: widget.isName
                    ? Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              autoFocus: true,
                              labelText: 'Update Name',
                              textType: TextInputType.name,
                              hintText: "Enter New Name",
                              defaultColor:
                                  TodoCubit.getCubit(context).currentUser!.userGender ==
                                          Constants.kMale
                                      ? ColorsTheme.manFloatingblueColor
                                      : ColorsTheme.blueWhiteColor,
                              validator: (value) {
                                if (value!.length < 4) {
                                  return 'Enter at least 4 characters';
                                } else if (value.compareTo(
                                        TodoCubit.getCubit(context)
                                            .currentUser!
                                            .userName) ==
                                    0) {
                                  return 'This Name match To Old Name ';
                                } else if (RegExp(r"\s")
                                    .hasMatch(value.trim())) {
                                  return 'we find white space';
                                } else {
                                  return null;
                                }
                              },
                              maxTextLength: 30,
                              onChanged: (value) {
                                WriteDataCubit.getCubit(context)
                                    .enterNewUserName(updateuserName: value!);
                              },
                            ),
                            customSizeBox(height: 15),
                            state is WriteLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomRoundButton(
                                    text: 'Done',
                                    onPress: () {
                                      if (formKey.currentState!.validate()) {
                                        WriteDataCubit.getCubit(context)
                                            .updateUserName();
                                      }
                                    },
                                    buttonColor: TodoCubit.getCubit(context)
                                                .currentUser!.userGender ==
                                            Constants.kMale
                                        ? ColorsTheme.manFloatingblueColor
                                        : ColorsTheme.womanFloatingpinkColor,
                                  )
                          ],
                        ),
                      )
                    : Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              autoFocus: true,
                              labelText: 'Old Password',
                              textType: TextInputType.visiblePassword,
                              hintText: "Enter Old Password",
                              defaultColor:
                                  TodoCubit.getCubit(context).currentUser!.userGender ==
                                          Constants.kMale
                                      ? ColorsTheme.manFloatingblueColor
                                      : ColorsTheme.blueWhiteColor,
                              validator: (value) {
                                if (value!.length < 7) {
                                  return 'Password must be at least 7 characters long';
                                } else if (value.compareTo(
                                        TodoCubit.getCubit(context)
                                            .currentUser!
                                            .userPassword) !=
                                    0) {
                                  return 'This Password must be match To Old Password ';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            customSizeBox(height: 20),
                            CustomTextFormField(
                              autoFocus: true,
                              labelText: 'Update Password',
                              textType: TextInputType.visiblePassword,
                              defaultColor:
                                  TodoCubit.getCubit(context).currentUser!.userGender ==
                                          Constants.kMale
                                      ? ColorsTheme.manFloatingblueColor
                                      : ColorsTheme.blueWhiteColor,
                              hintText: "Enter New Password",
                              obscureText: true,
                              validator: (value) {
                                if (value!.length < 7) {
                                  return 'Password must be at least 7 characters long';
                                } else if (value.compareTo(
                                        TodoCubit.getCubit(context)
                                            .currentUser!
                                            .userPassword) ==
                                    0) {
                                  return 'The New Password same as Old Password ';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                WriteDataCubit.getCubit(context)
                                    .enterNewUserPassword(
                                        updateuserPassword: value!);
                              },
                            ),
                            customSizeBox(height: 20),
                            state is WriteLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomRoundButton(
                                    text: 'Done',
                                    onPress: () {
                                      if (formKey.currentState!.validate()) {
                                        WriteDataCubit.getCubit(context)
                                            .updateUserPassword();
                                      }
                                    },
                                    buttonColor: TodoCubit.getCubit(context)
                                                .currentUser!.userGender ==
                                            Constants.kMale
                                        ? ColorsTheme.manFloatingblueColor
                                        : ColorsTheme.womanFloatingpinkColor,
                                  )
                          ],
                        ),
                      )),
          );
        },
      ),
    );
  }
}
