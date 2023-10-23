import 'package:equatable/equatable.dart';

class OnBoardingItem extends Equatable {
  final String image, title, body;
  const OnBoardingItem(
      {required this.image, required this.title, required this.body});

  @override
  List<Object?> get props => [image, title, body];
}
