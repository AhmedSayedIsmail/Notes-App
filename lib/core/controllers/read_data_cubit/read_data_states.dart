abstract class ReadDataStates {}

class InitialState extends ReadDataStates {}

class LoadingState extends ReadDataStates {}

class ReadUserCategoriesSuccessfully extends ReadDataStates {}

class ReadUserCategoriesFauild extends ReadDataStates {}

class ReadUserTasksSuccessfully extends ReadDataStates {}

class ReadUserTasksFauild extends ReadDataStates {}

class ReadCategoriesSuccessfully extends ReadDataStates {}

class ReadCategoriesFauild extends ReadDataStates {}

class TaskIsChecked extends ReadDataStates {}

class TaskIsCheckedFauild extends ReadDataStates {
  final String errorMessage;

  TaskIsCheckedFauild({required this.errorMessage});
}

class DeleteTaskAndCategoryFauild extends ReadDataStates {
  final String errorMessage;

  DeleteTaskAndCategoryFauild({required this.errorMessage});
}
