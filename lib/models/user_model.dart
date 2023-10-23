import 'package:equatable/equatable.dart';
import 'package:todo_application/core/sql_constants.dart';

class UserModel extends Equatable {
  final String userId;
  final String userName;
  final String userPassword;
  final String userGender;

  const UserModel(
      {required this.userId,
      required this.userName,
      required this.userPassword,
      required this.userGender});

  factory UserModel.fromJson(Map json) => UserModel(
        userId: json[SqlConstants.userId],
        userName: json[SqlConstants.userName],
        userPassword: json[SqlConstants.userPassword],
        userGender: json[SqlConstants.userSexType],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userData = <String, dynamic>{};
    userData[SqlConstants.userId] = userId;
    userData[SqlConstants.userName] = userName;
    userData[SqlConstants.userPassword] = userPassword;
    userData[SqlConstants.userSexType] = userGender;
    return userData;
  }

  @override
  List<Object?> get props => [
        userId,
        userName,
        userPassword,
        userGender,
      ];
}
