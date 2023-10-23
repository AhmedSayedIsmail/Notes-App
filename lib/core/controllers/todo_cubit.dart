import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/models/user_model.dart';
import 'package:todo_application/network/database/sql_database.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/todo_states.dart';
import 'package:todo_application/core/sql_constants.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialState());
  static TodoCubit getCubit(context) => BlocProvider.of(context);
  List<UserModel> usersList = [];
  UserModel? currentUser;
  String userName = "";
  String userPassword = "";
  String userGender = Constants.kMale;
  bool isChecked = false;
  bool hidePassword = true;
  bool isLogin = false;
  SqlDb sqlDb = SqlDb();

  insertUserName({required String userName}) {
    this.userName = userName;
  }

  insertUserPassword({required String userPassword}) {
    this.userPassword = userPassword;
  }

  insertUserGender({required String userGender}) {
    this.userGender = userGender;
    emit(InitialState());
  }

  updateCheckBox({required bool isChecked}) {
    this.isChecked = isChecked;
    emit(InitialState());
  }

  showingPassword() {
    hidePassword = !hidePassword;
    emit(InitialState());
  }

  ///This To Switch Between the the List of Screens
  selectScreen({required int selectedIndex, required context}) {
    currentPageIndex = selectedIndex;
    emit(ScreenChanged());
  }

  ///LogOut
  logOut() {
    emit(LogoutState());
  }

  //LoginUser
  loginUser({required BuildContext context}) async {
    isLogin = true;
    emit(LoadingState());
    bool isFound = _checkUserNameAndPassword();
    await Future.delayed(const Duration(seconds: 5));
    if (isFound) {
      emit(LoginUserSuccessfully());
    } else {
      emit(LoginUserFauild(
          errorMessage: 'Oops!UserName OR Password Not Correct'));
    }
  }

  ///Check When User Login
  bool _checkUserNameAndPassword() {
    bool isFound = false;
    if (isLogin) {
      for (var element in usersList) {
        if (userName.compareTo(element.userName) == 0 &&
            userPassword.compareTo(element.userPassword) == 0) {
          isFound = true;
          token = element.userId;
          break;
        } else {
          //Do HERE AnyThing
        }
      }
    } else {
      for (var element in usersList) {
        if (userName.compareTo(element.userName) != 0) {
          //Do HERE AnyThing
        } else {
          isFound = true;
          break;
        }
      }
    }
    return isFound;
  }

  //AddUsers
  addUser({required UserModel userModel, required BuildContext context}) async {
    emit(LoadingState());
    bool isFound = _checkUserNameAndPassword();
    await Future.delayed(const Duration(seconds: 5));
    try {
      if (isFound) {
        emit(
            AddUserFauild(errorMessage: "Oops!This Name $userName is Existed"));
      } else {
        await sqlDb.insertDataBase(
            tableName: SqlConstants.tableUsers, data: userModel.toJson());
        token = userModel.userId;
        readUsersData();
        emit(AddUserSuccessfully());
      }
    } catch (e) {
      emit(AddUserFauild(errorMessage: e.toString()));
    }
  }

  //ReadUsers
  Future readUsersData() async {
    try {
      //Here We will Fill the Model With Data
      usersList = List<UserModel>.from((await sqlDb.readDataBase(
              sql: "Select * From ${SqlConstants.tableUsers}"))
          .map((e) => UserModel.fromJson(e)));
      log("GetUsers:${usersList.toString()}");
      emit(ReadUsersSuccessfully());
    } catch (e) {
      log(e.toString());
      emit(ReadUsersFauild());
    }
  }

  //Read Data Of CurrentUser
  Future readCurrentUserData() async {
    try {
      var user = List<UserModel>.from((await sqlDb.readUserDataBase(
              tableName: SqlConstants.tableUsers,
              condition: '${SqlConstants.userId} = ?',
              args: token))
          .map((e) => UserModel.fromJson(e)));
      for (var element in user) {
        currentUser = UserModel(
            userId: element.userId,
            userName: element.userName,
            userPassword: element.userPassword,
            userGender: element.userGender);
      }
      log(currentUser!.userName);
      log(currentUser!.userPassword);
      log(currentUser!.userGender);
      if (isLogin) {
        emit(LoginReadUserSuccessfully());
      } else {
        emit(RegisterReadUserSuccessfully());
      }
    } catch (e) {
      log(e.toString());
      emit(ReadUserFauild());
    }
  }
}
