import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_application/screens/setting_screen/widget/edit_dialog_widget.dart';
import 'package:todo_application/screens/setting_screen/widget/warning_dialog_widget.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/todo_states.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CustomCards extends StatelessWidget {
  const CustomCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Card(
                color: Colors.grey.shade100,
                child: ListTile(
                    leading: const Icon(Icons.person_outlined),
                    title: const Text(
                      'Your Name',
                      style: TextStyle(color: Colors.grey),
                    ),
                    subtitle: Text(
                      "${TodoCubit.getCubit(context).currentUser?.userName}",
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) =>
                              const EditDialogWidget(isName: true)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(Icons.edit),
                      ),
                    )),
              ),
              customSizeBox(height: 20),
              Card(
                color: Colors.grey.shade100,
                child: ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: const Text(
                    "40 included",
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: SvgPicture.asset(
                      IconsAssets().assets[IconName.forwardarrow].toString()),
                ),
              ),
              customSizeBox(height: 20),
              Card(
                color: Colors.grey.shade100,
                child: ListTile(
                    leading: const Icon(Icons.lock_outlined),
                    title: const Text(
                      'Password',
                      style: TextStyle(color: Colors.grey),
                    ),
                    subtitle: Text(
                      TodoCubit.getCubit(context)
                          .currentUser!
                          .userPassword
                          .replaceRange(
                              0,
                              TodoCubit.getCubit(context)
                                  .currentUser!
                                  .userPassword
                                  .length,
                              "**********"),
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => const EditDialogWidget()),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(Icons.edit),
                      ),
                    )),
              ),
              customSizeBox(height: 20),
              Card(
                color: Colors.grey.shade100,
                child: ListTile(
                  leading: const Icon(Icons.error_outline_rounded),
                  title: const Text(
                    'About',
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: SvgPicture.asset(
                      IconsAssets().assets[IconName.forwardarrow].toString()),
                ),
              ),
              customSizeBox(height: 20),
              Card(
                color: Colors.grey.shade100,
                child: ListTile(
                    leading: const Icon(Icons.person_off_outlined),
                    title: const Text(
                      'Delete the Current User',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: InkWell(
                      onTap: () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const WarningDialogWidget()),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.delete,
                          color: ColorsTheme.redColor,
                        ),
                      ),
                    )),
              ),
              customSizeBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
