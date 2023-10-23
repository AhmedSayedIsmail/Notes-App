import 'package:equatable/equatable.dart';
import 'package:todo_application/core/sql_constants.dart';

class CategoryModel extends Equatable {
  final int categoryid;
  final String categoryimage;
  final String categorytype;
  final String? firstColor;
  final String? secondColor;
  const CategoryModel({
    required this.categoryid,
    required this.categoryimage,
    required this.categorytype,
    this.firstColor,
    this.secondColor,
  });

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) => CategoryModel(
      categoryid: json[SqlConstants.categoryId],
      categoryimage: json[SqlConstants.categoryImage],
      categorytype: json[SqlConstants.categoryType],
      firstColor: json[SqlConstants.categoryColor1],
      secondColor: json[SqlConstants.categoryColor2]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[SqlConstants.categoryId] = categoryid;
    data[SqlConstants.categoryImage] = categoryimage;
    data[SqlConstants.categoryType] = categorytype;
    data[SqlConstants.categoryColor1] = firstColor;
    data[SqlConstants.categoryColor2] = secondColor;
    return data;
  }

  @override
  List<Object?> get props => [
        categoryid,
        categoryimage,
        categorytype,
        firstColor,
        secondColor,
      ];
}
