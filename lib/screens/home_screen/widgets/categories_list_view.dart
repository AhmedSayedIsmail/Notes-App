import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_states.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    log("CategoriesListView");
    return BlocBuilder<ReadDataCubit, ReadDataStates>(
        builder: (context, state) => state is LoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ReadDataCubit.getCubit(context).userCategoriesList.isEmpty
                ? _getErrorMessage(context)
                : _containerListView(context));
  }

  Widget _containerListView(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => _categoriesCard(
        onTap: () {
          log(ReadDataCubit.getCubit(context)
              .userCategoriesList[index]
              .categoryId
              .toString());
        },
        backgroundcolor: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? Colors.white
            : ColorsTheme.womanDrawerBackgroundColor,
        tasksnumbers: ReadDataCubit.getCubit(context)
            .userCategoriesList[index]
            .numbertasks,
        title: ReadDataCubit.getCubit(context)
            .userCategoriesList[index]
            .usercategorytype,
        titleColor: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? ColorsTheme.blackColor
            : Colors.white,
        index: index,
        tasksnumberColor: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? ColorsTheme.blueBlackColor
            : ColorsTheme.blueWhiteColor,
      ),
      separatorBuilder: (BuildContext context, int index) =>
          customSizeBox(width: 25),
      itemCount: ReadDataCubit.getCubit(context).userCategoriesList.length,
    );
  }

  Widget _getErrorMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconsAssets().assets[IconName.categoryicon].toString(),
            color: TodoCubit.getCubit(context).currentUser!.userGender ==
                    Constants.kMale
                ? Colors.grey
                : ColorsTheme.blueWhiteColor,
            height: 55,
          ),
          customSizeBox(
            height: 20,
          ),
          Text(
            Constants.kNotCategoriesFounds,
            style: TextStyle(
                fontSize: 16,
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? Colors.grey
                    : ColorsTheme.blueWhiteColor),
          ),
          Text(
            Constants.kNotCategoriesFounds2,
            style: TextStyle(
                fontSize: 16,
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? Colors.grey
                    : Colors.amber),
          )
        ],
      ),
    );
  }

  _categoriesCard(
      {required onTap,
      required Color backgroundcolor,
      required int tasksnumbers,
      required String title,
      required Color titleColor,
      required Color tasksnumberColor,
      required int index}) {
    final colors = [
      ColorsTheme.purple,
      ColorsTheme.bluedarkColor,
    ];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: 250,
        height: double.infinity,
        decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$tasksnumbers tasks",
                style: TextStyle(color: tasksnumberColor),
              ),
              customSizeBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: titleColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Slider(
                  value: tasksnumbers.toDouble(),
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  label: '${tasksnumbers.round()}',
                  activeColor: colors[index % colors.length],
                  onChanged: (double value) {}),
            ],
          ),
        ),
      ),
    );
  }
}
