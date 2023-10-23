import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/core/sql_constants.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    _db ??= await init();
    return _db;
  }

  Future<Database> init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, SqlConstants.dbName);
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreateDatabase,
      version: SqlConstants.version,
      onUpgrade: _upgradeDataBase,
    );
    return mydb;
  }

  Future<void> _upgradeDataBase(db, oldVersion, newVersion) async {
    log("Upgraded************************************************");
  }

  Future<void> _onCreateDatabase(db, version) async {
    await db.execute(
        '''CREATE TABLE ${SqlConstants.tableUsers}(${SqlConstants.userId} String PRIMARY KEY,${SqlConstants.userName} STRING NOT NULL,${SqlConstants.userPassword} TEXT NOT NULL,${SqlConstants.userSexType} STRING NOT NULL)''');
    await db.execute(
        '''CREATE TABLE ${SqlConstants.tableTasks} (${SqlConstants.columnId} INTEGER NOT NULL, ${SqlConstants.columnTitle} STRING NOT NULL,${SqlConstants.columnNote} TEXT NOT NULL,${SqlConstants.columnDate} STRING NOT NULL,${SqlConstants.columnStartTime} STRING NOT NULL,${SqlConstants.columnEndTime} STRING NOT NULL,${SqlConstants.columnRemind} INTEGER NOT NULL,${SqlConstants.columnRepeat} STRING NOT NULL,${SqlConstants.columnUserId} String NOT NULL,${SqlConstants.columnIsCompleted} INTEGER NOT NULL,${SqlConstants.categoryType} STRING NOT NULL)''');
    await db.execute(
        '''CREATE TABLE ${SqlConstants.tableCategory} (${SqlConstants.categoryId} INTEGER NOT NULL, ${SqlConstants.categoryImage} STRING NOT NULL,${SqlConstants.categoryType} STRING NOT NULL,${SqlConstants.categoryColor1} STRING,${SqlConstants.categoryColor2} STRING )''');
    await db.execute(
        '''CREATE TABLE ${SqlConstants.tableUserCategories} (${SqlConstants.categoryId} INTEGER NOT NULL, ${SqlConstants.categoryImage} STRING NOT NULL,${SqlConstants.categoryType} STRING NOT NULL,${SqlConstants.numberTasks} INTEGER NOT NULL,${SqlConstants.categoryColor1} STRING,${SqlConstants.categoryColor2} STRING,${SqlConstants.columnUserId} String NOT NULL)''');
    log("Create DataBase Successfully**************************************************************");
  }

  //ReadDataBase
  Future<List<Map>> readDataBase({required String sql}) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  //ReadUserData
  Future<List<Map>> readUserDataBase({required String tableName,String?condition,args}) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(tableName,where: condition,whereArgs:[args]);
    return response;
  }
  //InsertDaratBase
  Future<int> insertDataBase(
      {required String tableName, required Map<String, dynamic> data}) async {
    Database? mydb = await db;
    int response = await mydb!.insert(tableName, data);
    return response;
  }

  //UpdataDataBase
  Future<int> updateDataBase({required String sql,List<Object?>? arg}) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql,arg);
    return response;
  }

  //DeleteDataBase
  Future<int> deleteDataBase({required String sql,List<Object?>? arg}) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql,arg);
    return response;
  }
}
