import 'package:equatable/equatable.dart';
import 'package:todo_application/core/sql_constants.dart';

class TaskModel extends Equatable {
  final int id;
  final String title;
  final String note;
  final String date;
  final String startTime;
  final String endTime;
  final int remind;
  final String repeat;
  final String userId;
  final int isCompleted;
  final String catgoryname;
  const TaskModel(
      {required this.id,
      required this.title,
      required this.note,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.remind,
      required this.repeat,
      required this.userId,
      required this.isCompleted,
      required this.catgoryname});

  factory TaskModel.fromJson(Map<dynamic, dynamic> json) => TaskModel(
      id: json[SqlConstants.columnId],
      title: json[SqlConstants.columnTitle],
      note: json[SqlConstants.columnNote],
      date: json[SqlConstants.columnDate],
      startTime: json[SqlConstants.columnStartTime],
      endTime: json[SqlConstants.columnEndTime],
      remind: json[SqlConstants.columnRemind],
      repeat: json[SqlConstants.columnRepeat],
      userId: json[SqlConstants.columnUserId],
      isCompleted: json[SqlConstants.columnIsCompleted],
      catgoryname: json[SqlConstants.categoryType]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[SqlConstants.columnId] = id;
    data[SqlConstants.columnTitle] = title;
    data[SqlConstants.columnNote] = note;
    data[SqlConstants.columnDate] = date;
    data[SqlConstants.columnStartTime] = startTime;
    data[SqlConstants.columnEndTime] = endTime;
    data[SqlConstants.columnRemind] = remind;
    data[SqlConstants.columnRepeat] = repeat;
    data[SqlConstants.columnUserId] = userId;
    data[SqlConstants.columnIsCompleted] = isCompleted;
    data[SqlConstants.categoryType] = catgoryname;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        note,
        date,
        startTime,
        endTime,
        remind,
        repeat,
        userId,
        isCompleted,
        catgoryname
      ];
}
