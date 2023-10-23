import 'package:flutter/material.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CustomRadioButton extends StatelessWidget {
  final String gender;
  const CustomRadioButton({super.key, required this.gender});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
                fillColor: MaterialStateColor.resolveWith(
                    (states) => ColorsTheme.redColor),
                focusColor: MaterialStateColor.resolveWith(
                    (states) => ColorsTheme.redColor),
                value: Constants.kMale,
                groupValue: gender,
                onChanged: (value) {
                  TodoCubit.getCubit(context)
                      .insertUserGender(userGender: value!);
                }),
            const Text(
              Constants.kMale,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
                fillColor: MaterialStateColor.resolveWith(
                    (states) => ColorsTheme.redColor),
                focusColor: MaterialStateColor.resolveWith(
                    (states) => ColorsTheme.redColor),
                value: Constants.kFemale,
                groupValue: gender,
                onChanged: (value) {
                  TodoCubit.getCubit(context)
                      .insertUserGender(userGender: value!);
                }),
            const Text(
              Constants.kFemale,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ],
    );
  }
}
