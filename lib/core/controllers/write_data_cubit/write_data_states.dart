abstract class WriteDataStates {}

class WriteInitialState extends WriteDataStates {}

class WriteLoadingState extends WriteDataStates {}

class AddTaskFauild extends WriteDataStates {
  final String message;
  AddTaskFauild({required this.message});
}

class AddTaskSuccessfully extends WriteDataStates {}

class UpdateUserDataSuccessfully extends WriteDataStates {}

class DeleteUserSuccessfully extends WriteDataStates {}

class DeleteUserFauild extends WriteDataStates {}
