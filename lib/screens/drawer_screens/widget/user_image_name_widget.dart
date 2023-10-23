import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/todo_states.dart';
import 'package:todo_application/core/images_assets.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class UserImageNameWidget extends StatelessWidget {
  const UserImageNameWidget({super.key});
  @override
  Widget build(BuildContext context) {
    log("UserImageNameWidget");
    return BlocBuilder<TodoCubit, TodoStates>(
      builder: (context, state) {
        return Row(children: [
          Stack(
            children: [
              CircleAvatar(
                radius: Constants.kCircleAvaterRaduis,
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
              Positioned(
                  bottom: 0,
                  right: 12,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                        color: ColorsTheme.activeStatusColor,
                        shape: BoxShape.circle),
                  ))
            ],
          ),
          customSizeBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${TodoCubit.getCubit(context).currentUser?.userName}',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Text('Active Status',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          )
        ]);
      },
    );
  }
}
