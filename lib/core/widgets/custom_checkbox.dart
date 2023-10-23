import 'package:flutter/material.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final Function(bool?) onChanged;
  const CustomCheckBox(
      {super.key, required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Checkbox(
              activeColor: ColorsTheme.blueColor,
              value: isChecked, // mycubit.isChecked,
              onChanged: onChanged),
          GestureDetector(
            onTap: () => {}, // mycubit.changeCheckBox(),
            child: const Text(
              Constants.checkboxText,
              style: TextStyle(fontSize: 16, color: ColorsTheme.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
