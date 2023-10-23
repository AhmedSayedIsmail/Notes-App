abstract class SqlConstants {
  static const String dbName = "tasks.db";
  static const int version = 1;
  static const String tableUsers = "users";
  static const String userId = "user_id";
  static const String userName = "user_name";
  static const String userPassword = "user_password";
  static const String userSexType = "user_sex";
// --------------------------------------------------
  static const String tableTasks = "tasks";
  static const String columnId = "id";
  static const String columnTitle = "title";
  static const String columnNote = "note";
  static const String columnDate = "date";
  static const String columnStartTime = "startTime";
  static const String columnEndTime = "endTime";
  static const String columnRemind = "remind";
  static const String columnRepeat = "repeat";
  static const String columnUserId = "user_id";
  static const String columnIsCompleted = "isCompleted";
//-------------------------------------------------------  
  static const String tableCategory = "categories";
  static const String categoryId = "categoryId";
  static const String categoryImage = "categoryImage";
  static const String categoryType = "categoryType";
  static const String categoryColor1 = "categoryFColor";
  static const String categoryColor2 = "categorySColor";
  static const String tableUserCategories = "user_categories";
  static const String numberTasks = "number_tasks";
}
