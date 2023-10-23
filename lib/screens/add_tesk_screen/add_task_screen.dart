import 'package:flutter/material.dart';
import 'package:todo_application/screens/add_tesk_screen/widget/custom_column_form_text_fields.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/images_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class AddTaskScreen extends StatelessWidget {
  static const String id = "AddTaskScreen";
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CircleAvatar(
              backgroundColor: ColorsTheme.brownColor,
              backgroundImage: TodoCubit.getCubit(context)
                          .currentUser!
                          .userGender ==
                      Constants.kMale
                  ? AssetImage(
                      ImagesAssets().assets[AssetName.manProfile2].toString())
                  : AssetImage(ImagesAssets()
                      .assets[AssetName.womanProfile2]
                      .toString()),
            ),
          ),
        ],
        elevation: 0,
        title: Text(
          Constants.kAddTaskText,
          style: TextStyle(
              fontSize: 25,
              color: TodoCubit.getCubit(context).currentUser!.userGender ==
                      Constants.kMale
                  ? ColorsTheme.blueBlackColor
                  : ColorsTheme.womanHomeBackgroundColor,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: TodoCubit.getCubit(context).currentUser!.userGender ==
                    Constants.kMale
                ? ColorsTheme.blueBlackColor
                : ColorsTheme.womanFloatingpinkColor),
      ),
      body: CustomColumnFormTextField(
        formkey: formKey,
      ),
    );
  }
}
