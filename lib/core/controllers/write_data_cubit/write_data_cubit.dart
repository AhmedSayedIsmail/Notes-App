import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/models/category_model.dart';
import 'package:todo_application/models/tasks_model.dart';
import 'package:todo_application/models/user_category_model.dart';
import 'package:todo_application/network/database/sql_database.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/controllers/write_data_cubit/write_data_states.dart';
import 'package:todo_application/core/sql_constants.dart';

class WriteDataCubit extends Cubit<WriteDataStates> {
  WriteDataCubit() : super(WriteInitialState());
  static WriteDataCubit getCubit(context) => BlocProvider.of(context);
  String titleTask = "";
  String noteTask = "";
  String dateTask = "";
  String startTime = "";
  String endTime = "";
  String repeatTask = "";
  String categoryType = "";
  int remindTask = 0;
  UserCategoryModel? newuserCategory;
  TaskModel? newTask;
  bool isCategoryFound = false;
  String updateuserName = "";
  String updateuserPassword = "";

  updateTitleTask({required String titleTask}) {
    this.titleTask = titleTask;
    emit(WriteInitialState());
  }

  updateNoteTask({required String noteTask}) {
    this.noteTask = noteTask;
    emit(WriteInitialState());
  }

  updateDateTask({required DateTime dateTask}) {
    this.dateTask = dateTimeFormat(dateTask);
    emit(WriteInitialState());
  }

  updateStartTimeTask({required String startTime}) {
    this.startTime = startTime;
    emit(WriteInitialState());
  }

  updatUpdateEndTimeTask({required String endTime}) {
    this.endTime = endTime;
    emit(WriteInitialState());
  }

  updatUpdateRemindTask({required int remindTask}) {
    this.remindTask = remindTask;
    emit(WriteInitialState());
  }

  updatUpdateRepeatTask({required String repeatTask}) {
    this.repeatTask = repeatTask;
    emit(WriteInitialState());
  }

  enterNewUserName({required String updateuserName}) {
    this.updateuserName = updateuserName;
    emit(WriteInitialState());
  }

  enterNewUserPassword({required String updateuserPassword}) {
    this.updateuserPassword = updateuserPassword;
    emit(WriteInitialState());
  }

  updatUpdateCategoryTask(
      {required int categoryId,
      required List<CategoryModel> allCategories,
      required List<UserCategoryModel> allUserCategories}) {
    if (allUserCategories.isNotEmpty) {
      for (var i in allCategories) {
        if (categoryId == i.categoryid) {
          categoryType = i.categorytype;
          for (var j in allUserCategories) {
            if (i.categoryid == j.categoryId) {
              newuserCategory = UserCategoryModel(
                  categoryId: categoryId,
                  usercategoryimage: i.categoryimage,
                  usercategorytype: i.categorytype,
                  firstColor: i.firstColor,
                  secondColor: i.secondColor,
                  numbertasks: j.numbertasks + 1,
                  userid: token!);
              isCategoryFound = true;
              break;
            } else {
              newuserCategory = UserCategoryModel(
                  categoryId: categoryId,
                  usercategoryimage: i.categoryimage,
                  usercategorytype: i.categorytype,
                  firstColor: i.firstColor,
                  secondColor: i.secondColor,
                  numbertasks: 1,
                  userid: token!);
            }
          }
          break;
        }
      }
    } else {
      for (var i in allCategories) {
        if (categoryId == i.categoryid) {
          categoryType = i.categorytype;
          newuserCategory = UserCategoryModel(
              categoryId: categoryId,
              usercategoryimage: i.categoryimage,
              usercategorytype: i.categorytype,
              firstColor: i.firstColor,
              secondColor: i.secondColor,
              numbertasks: 1,
              userid: token!);
          break;
        }
      }
    }
    emit(WriteInitialState());
  }

  Future<void> addTask() async {
    emit(WriteLoadingState());
    await Future.delayed(const Duration(seconds: 8)).then((value) {
      if (dateTask.isEmpty ||
          startTime.isEmpty ||
          endTime.isEmpty ||
          remindTask == 0 ||
          repeatTask.isEmpty ||
          categoryType.isEmpty) {
        emit(AddTaskFauild(message: "Please Enter All Data"));
      } else {
        newTask = TaskModel(
            id: generateRandomInteger(),
            title: titleTask,
            note: noteTask,
            date: dateTask,
            startTime: startTime,
            endTime: endTime,
            remind: remindTask,
            repeat: repeatTask,
            userId: token!,
            isCompleted: 0,
            catgoryname: categoryType);
        if (isCategoryFound) {
          _addNewTaskAndUpdateCategory();
        } else {
          _addNewTaskAndCategory();
        }
      }
    });
  }

  Future<void> _addNewTaskAndCategory() async {
    await SqlDb()
        .insertDataBase(
            tableName: SqlConstants.tableTasks, data: newTask!.toJson())
        .then((value) async {
      await SqlDb()
          .insertDataBase(
              tableName: SqlConstants.tableUserCategories,
              data: newuserCategory!.toJson())
          .then((value) {
        emit(AddTaskSuccessfully());
      }).catchError((e) {
        emit(AddTaskFauild(message: e));
      });
    }).catchError((e) {
      emit(AddTaskFauild(message: e));
    });
  }

  Future<void> _addNewTaskAndUpdateCategory() async {
    await SqlDb()
        .insertDataBase(
            tableName: SqlConstants.tableTasks, data: newTask!.toJson())
        .then((value) async {
      await SqlDb().updateDataBase(
          sql:
              "Update ${SqlConstants.tableUserCategories} Set  ${SqlConstants.numberTasks} =? Where ${SqlConstants.categoryId}=?  ",
          arg: [
            newuserCategory!.numbertasks,
            newuserCategory!.categoryId
          ]).then((value) {
        emit(AddTaskSuccessfully());
      }).catchError((e) {
        emit(AddTaskFauild(message: e));
      });
    }).catchError((e) {
      emit(AddTaskFauild(message: e));
    });
  }

  ///Update Name Of User
  Future<void> updateUserName() async {
    emit(WriteLoadingState());
    await Future.delayed(const Duration(seconds: 5)).then((value) async {
      await SqlDb().updateDataBase(
          sql:
              "Update ${SqlConstants.tableUsers} Set  ${SqlConstants.userName} =? Where ${SqlConstants.userId}=?  ",
          arg: [updateuserName, token]).then((value) {
        emit(UpdateUserDataSuccessfully());
      });
    });
  }

  ///Update Password Of User
  Future<void> updateUserPassword() async {
    emit(WriteLoadingState());
    await Future.delayed(const Duration(seconds: 5)).then((value) async {
      await SqlDb().updateDataBase(
          sql:
              "Update ${SqlConstants.tableUsers} Set  ${SqlConstants.userPassword} =? Where ${SqlConstants.userId}=?  ",
          arg: [updateuserPassword, token]).then((value) {
        emit(UpdateUserDataSuccessfully());
      });
    });
  }

  //Delete User
  deleteUserData() async {
    emit(WriteLoadingState());
    await Future.delayed(const Duration(seconds: 5));
    try {
      // DELETE FROM Test WHERE name = ?', ['another name']
      await SqlDb().deleteDataBase(
          sql:
              "Delete From ${SqlConstants.tableUsers} Where ${SqlConstants.userId} = ? ",
          arg: [token]).then((value) async {
        await SqlDb().deleteDataBase(
            sql:
                "Delete From ${SqlConstants.tableTasks} Where ${SqlConstants.columnUserId} = ? ",
            arg: [token]).then((value) async {
          await SqlDb().deleteDataBase(
              sql:
                  "Delete From ${SqlConstants.tableUserCategories} Where ${SqlConstants.columnUserId} = ? ",
              arg: [token]).then((value) {
            emit(DeleteUserSuccessfully());
          });
        });
      });
    } catch (e) {
      emit(DeleteUserFauild());
    }
  }
}
