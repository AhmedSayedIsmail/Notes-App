import 'package:flutter/material.dart';

class CustomRoundButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  final Color buttonColor;
  final double width;
  const CustomRoundButton(
      {Key? key,
      required this.text,
      required this.onPress,
      required this.buttonColor, 
      this.width =150})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        height: 50,
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            textStyle: const TextStyle(fontSize: 20),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
