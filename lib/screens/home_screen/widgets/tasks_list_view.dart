import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_states.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/icons_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataStates>(
        builder: (context, state) => state is LoadingState
            ? const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ReadDataCubit.getCubit(context).userTasksList.isEmpty
                ? _getEmptyMessage(context)
                : _containerListView(context));
  }

  Widget _containerListView(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _todayCard(
            index: index,
            isChecked:
                ReadDataCubit.getCubit(context).checkStatus(index: index),
            onChanged: (newCheck) {
              ReadDataCubit.getCubit(context).checkTaskIsCompleted(
                  taskId:
                      ReadDataCubit.getCubit(context).userTasksList[index].id,
                  index: index);
            },
            text: ReadDataCubit.getCubit(context).userTasksList[index].note,
            dismissed: (direction) {
              ReadDataCubit.getCubit(context).deleteTask(
                  taskId:
                      ReadDataCubit.getCubit(context).userTasksList[index].id,
                  categoryName: ReadDataCubit.getCubit(context)
                      .userTasksList[index]
                      .catgoryname);
            },
            cardColor: TodoCubit.getCubit(context).currentUser?.userGender ==
                    Constants.kMale
                ? Colors.white
                : ColorsTheme.womanDrawerBackgroundColor,
            textColor: TodoCubit.getCubit(context).currentUser?.userGender ==
                    Constants.kMale
                ? Colors.black
                : Colors.white,
          );
        },
        separatorBuilder: (context, _) => customSizeBox(
              height: 20,
            ),
        itemCount: ReadDataCubit.getCubit(context).userTasksList.length);
  }

  Widget _getEmptyMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconsAssets().assets[IconName.todoicon].toString(),
            color: TodoCubit.getCubit(context).currentUser!.userGender ==
                    Constants.kMale
                ? Colors.grey
                : ColorsTheme.blueWhiteColor,
            height: 85,
          ),
          customSizeBox(
            height: 20,
          ),
          Text(
            Constants.kNotTasksFounds,
            style: TextStyle(
                fontSize: 16,
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? Colors.grey
                    : ColorsTheme.blueWhiteColor),
          ),
          Text(
            Constants.kNotTasksFounds2,
            style: TextStyle(
                fontSize: 17,
                color: TodoCubit.getCubit(context).currentUser!.userGender ==
                        Constants.kMale
                    ? Colors.grey
                    : Colors.amber),
          )
        ],
      ),
    );
  }

  Widget _todayCard(
      {required Function(dynamic direction)? dismissed,
      required cardColor,
      required Color textColor,
      required text,
      required Function(bool?)? onChanged,
      required bool isChecked,
      required int index}) {
    final colors = [
      ColorsTheme.purple,
      ColorsTheme.bluedarkColor,
    ];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: dismissed,
      child: Card(
        color: cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onChanged,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(
                  (state) => colors[index % colors.length]),
              shape: const CircleBorder(),
            ),
            isChecked
                ? Text(
                    text,
                    style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 4,
                        color: textColor,
                        decorationColor: colors[index % colors.length]),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
