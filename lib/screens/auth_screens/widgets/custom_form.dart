import 'package:flutter/material.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';
import 'package:todo_application/core/widgets/custom_text_form_field.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  const CustomForm({super.key, required this.formkey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextFormField(
              autoFocus: true,
              textType: TextInputType.name,
              labelText: 'Username',
              hintText: "Enter Name",
              validator: (value) {
                if (value!.length < 4) {
                  return 'Enter at least 4 characters';
                } else if (RegExp(r"\s").hasMatch(value.trim())) {
                  return 'we find white space';
                } else {
                  return null;
                }
              },
              defaultColor: ColorsTheme.darkGreyClr,
              onChanged: (value) {
                TodoCubit.getCubit(context).insertUserName(userName: value!);
              }),
          const SizedBox(height: 16),
          CustomTextFormField(
              textType: TextInputType.visiblePassword,
              labelText: 'Password',
              hintText: 'Enter Password',
              defaultColor: ColorsTheme.darkGreyClr,
              suffixIcon: IconButton(
                  onPressed: () {
                    TodoCubit.getCubit(context).showingPassword();
                  },
                  icon: TodoCubit.getCubit(context).hidePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility)),
              validator: (value) {
                if (value!.length < 7) {
                  return 'Password must be at least 7 characters long';
                } else {
                  return null;
                }
              },
              obscureText: TodoCubit.getCubit(context).hidePassword,
              onChanged: (value) {
                TodoCubit.getCubit(context)
                    .insertUserPassword(userPassword: value!);
              })
        ],
      ),
    );
  }
}
