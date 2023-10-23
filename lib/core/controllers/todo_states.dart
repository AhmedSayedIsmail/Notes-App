abstract class TodoStates {}

class InitialState extends TodoStates {}

class LoadingState extends TodoStates {}

class ReadUsersSuccessfully extends TodoStates {}

class LoginReadUserSuccessfully extends TodoStates {}

class RegisterReadUserSuccessfully extends TodoStates {}

class AddUserSuccessfully extends TodoStates {}

class AddUserFauild extends TodoStates {
  final String errorMessage;
  AddUserFauild({required this.errorMessage});
}

class ReadUsersFauild extends TodoStates {}

class ReadUserFauild extends TodoStates {}

class LoginUserSuccessfully extends TodoStates {}

class LoginUserFauild extends TodoStates {
  final String errorMessage;
  LoginUserFauild({required this.errorMessage});
}

class ScreenChanged extends TodoStates {}

class LogoutState extends TodoStates {}