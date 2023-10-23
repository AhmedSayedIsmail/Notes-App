import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_application/screens/category_screen/widget/category_small_card.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_states.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class UserCategoryList extends StatelessWidget {
  const UserCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    log(ReadDataCubit.getCubit(context).userCategoriesList.isEmpty.toString());
    return BlocBuilder<ReadDataCubit, ReadDataStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ReadDataCubit.getCubit(context).userCategoriesList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customSizeBox(height: 200),
                    SvgPicture.asset(
                      IconsAssets().assets[IconName.categoryicon].toString(),
                      color:
                          TodoCubit.getCubit(context).currentUser!.userGender ==
                                  Constants.kMale
                              ? Colors.grey
                              : ColorsTheme.blueWhiteColor,
                      height: 100,
                    ),
                    customSizeBox(
                      height: 20,
                    ),
                    Text(
                      Constants.kNotCategoriesFounds,
                      style: TextStyle(
                          fontSize: 16,
                          color: TodoCubit.getCubit(context)
                                      .currentUser!
                                      .userGender ==
                                  Constants.kMale
                              ? Colors.grey
                              : ColorsTheme.blueWhiteColor),
                    ),
                    Text(
                      Constants.kNotCategoriesFounds2,
                      style: TextStyle(
                          fontSize: 16,
                          color: TodoCubit.getCubit(context)
                                      .currentUser!
                                      .userGender ==
                                  Constants.kMale
                              ? Colors.grey
                              : Colors.amber),
                    )
                  ],
                )
              : GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 19,
                      mainAxisExtent: 125,
                      mainAxisSpacing: 19),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: ReadDataCubit.getCubit(context)
                      .userCategoriesList
                      .map(
                        (element) => CategoriesSmallCard(
                            onTap: () {},
                            title: element.usercategorytype,
                            gradientStartColor: element.firstColor == "null"
                                ? null
                                : Color(int.parse(element.firstColor!)),
                            gradientEndColor: element.firstColor == "null"
                                ? null
                                : Color(int.parse(element.secondColor!)),
                            image: element.usercategoryimage,
                            tasksNum: element.numbertasks),
                      )
                      .toList()),
        );
      },
    );
  }
}
