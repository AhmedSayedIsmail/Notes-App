import 'package:equatable/equatable.dart';
import 'package:todo_application/core/sql_constants.dart';

class UserCategoryModel extends Equatable {
  final int categoryId;
  final String usercategoryimage;
  final String usercategorytype;
  final int numbertasks;
  final String? firstColor;
  final String? secondColor;
  final String userid;

  const UserCategoryModel(
      {required this.categoryId,
      required this.usercategoryimage,
      required this.usercategorytype,
      required this.numbertasks,
      this.firstColor,
      this.secondColor,
      required this.userid});

  factory UserCategoryModel.fromJson(Map<dynamic, dynamic> json) =>
      UserCategoryModel(
          categoryId: json[SqlConstants.categoryId],
          usercategoryimage: json[SqlConstants.categoryImage],
          usercategorytype: json[SqlConstants.categoryType],
          numbertasks: json[SqlConstants.numberTasks],
          firstColor: json[SqlConstants.categoryColor1],
          secondColor: json[SqlConstants.categoryColor2],
          userid: json[SqlConstants.columnUserId]);

  @override
  List<Object?> get props => [
        categoryId,
        usercategoryimage,
        usercategorytype,
        numbertasks,
        firstColor,
        secondColor,
        userid
      ];

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[SqlConstants.categoryId] = categoryId;
    data[SqlConstants.categoryImage] = usercategoryimage;
    data[SqlConstants.categoryType] = usercategorytype;
    data[SqlConstants.numberTasks] = numbertasks;
    data[SqlConstants.categoryColor1] = firstColor;
    data[SqlConstants.categoryColor2] = secondColor;
    data[SqlConstants.columnUserId] = userid;
    return data;
  }
}
