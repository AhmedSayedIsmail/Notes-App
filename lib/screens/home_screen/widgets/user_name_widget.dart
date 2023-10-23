import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/todo_states.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0),
          child: Text(
            "What's up, ${TodoCubit.getCubit(context).currentUser!.userName}!",
            style: TextStyle(
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? ColorsTheme.blueBlackColor
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
        );
      },
    );
  }
}
