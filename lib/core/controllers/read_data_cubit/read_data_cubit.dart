import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/models/category_model.dart';
import 'package:todo_application/models/tasks_model.dart';
import 'package:todo_application/models/user_category_model.dart';
import 'package:todo_application/network/database/sql_database.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_states.dart';
import 'package:todo_application/core/sql_constants.dart';

class ReadDataCubit extends Cubit<ReadDataStates> {
  ReadDataCubit() : super(InitialState());
  static ReadDataCubit getCubit(context) => BlocProvider.of(context);
  List<TaskModel> userTasksList = [];
  List<UserCategoryModel> userCategoriesList = [];
  List<CategoryModel> categoriesList = [];
  List<int> check = [];
  //ReadUserTasks
  Future readUserTasks() async {
    await _tryAndCatch(
        tryAction: () async {
          log("*-*readUserTasks*-*");
          userTasksList = List<TaskModel>.from((await SqlDb().readUserDataBase(
                  tableName: SqlConstants.tableTasks,
                  condition: '${SqlConstants.columnUserId} = ?',
                  args: token))
              .map((e) => TaskModel.fromJson(e)));
          log("GetUserTasks:${userTasksList.toString()}");
          check = userTasksList.map((e) => e.isCompleted).toList();
          emit(ReadUserTasksSuccessfully());
        },
        state: ReadUserTasksFauild());
  }

  //ReadUserCategories
  Future readUserCategoies() async {
    await _tryAndCatch(
        tryAction: () async {
          log("*-*readUserCategoies*-*");
          userCategoriesList = List<UserCategoryModel>.from((await SqlDb()
                  .readUserDataBase(
                      tableName: SqlConstants.tableUserCategories,
                      condition: '${SqlConstants.columnUserId} = ?',
                      args: token))
              .map((e) => UserCategoryModel.fromJson(e)));
          log("GetUserCategories:${userCategoriesList.toString()}");
          emit(ReadUserCategoriesSuccessfully());
        },
        state: ReadUserCategoriesFauild());
  }

  ///Read Categories
  Future readCategoies() async {
    log("*-*readCategoies*-*");
    await Future.delayed(const Duration(seconds: 5)).then((value) async {
      try {
        categoriesList = List<CategoryModel>.from((await SqlDb().readDataBase(
                sql: "Select * From ${SqlConstants.tableCategory}"))
            .map((e) => CategoryModel.fromJson(e)));
        log("GetCategories:${categoriesList.toString()}");
        emit(ReadCategoriesSuccessfully());
      } catch (e) {
        emit(ReadCategoriesFauild());
      }
    });
  }

  ///Check is Task isCompleted or not
  Future<void> checkTaskIsCompleted(
      {required int taskId, required int index}) async {
    if (check[index] == 0) {
      check[index] = 1;
    } else {
      check[index] = 0;
    }
    await SqlDb().updateDataBase(
        sql:
            "Update ${SqlConstants.tableTasks} Set ${SqlConstants.columnIsCompleted} =? Where ${SqlConstants.columnId} =? ",
        arg: [check[index], taskId]).then((value) {
      log(value.toString());
      checkStatus(index: index);
      emit(TaskIsChecked());
    }).catchError((error) {
      emit(TaskIsCheckedFauild(errorMessage: error));
    });
  }

  bool checkStatus({required int index}) {
    if (check[index] == 0) {
      return false;
    }
    return true;
  }

  ///Delete Task From List
  Future deleteTask({required int taskId, required String categoryName}) async {
    for (var element in userCategoriesList) {
      if (categoryName.compareTo(element.usercategorytype) == 0) {
        if (element.numbertasks == 1) {
          await SqlDb().deleteDataBase(
              sql:
                  "Delete From ${SqlConstants.tableTasks} Where ${SqlConstants.columnId} = ?",
              arg: [taskId]).then((value) async {
            log(value.toString());
            await SqlDb().deleteDataBase(
                sql:
                    "Delete From ${SqlConstants.tableUserCategories} Where ${SqlConstants.categoryType}=?",
                arg: [categoryName]).then((value) {
              readUserTasks();
              readUserCategoies();
            }).catchError((error) {
              emit(DeleteTaskAndCategoryFauild(errorMessage: error));
            });
          }).catchError((error) {
            emit(DeleteTaskAndCategoryFauild(errorMessage: error));
          });
        } else {
          log("Dec Number Tasks that inside Category");
          await SqlDb().deleteDataBase(
              sql:
                  "Delete From ${SqlConstants.tableTasks} Where ${SqlConstants.columnId} = ?",
              arg: [taskId]).then((value) async {
            log(value.toString());
            await SqlDb().deleteDataBase(
                sql:
                    "Update ${SqlConstants.tableUserCategories} Set  ${SqlConstants.numberTasks} =? Where ${SqlConstants.categoryType}=?  ",
                arg: [element.numbertasks - 1, categoryName]).then((value) {
              readUserTasks();
              readUserCategoies();
            }).catchError((error) {
              emit(DeleteTaskAndCategoryFauild(errorMessage: error));
            });
          }).catchError((error) {
            emit(DeleteTaskAndCategoryFauild(errorMessage: error));
          });
        }
        break;
      } else {
        ///Do Here AnyThing
      }
    }
  }

  Future<void> _tryAndCatch(
      {required VoidCallback tryAction, required state}) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 5));
    try {
      tryAction.call();
    } catch (e) {
      log(e.toString());
      emit(state);
    }
  }
}