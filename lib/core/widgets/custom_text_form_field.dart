import 'package:flutter/material.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final bool autoFocus;
  final bool readOnly;
  final TextInputType textType;
  final Color? defaultColor;
  final String? labelText;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int? maxTextLength;
  final Function(String?)? onChanged;
  final bool obscureText;
  const CustomTextFormField({
    super.key,
    this.autoFocus = false,
    this.readOnly = false,
    required this.textType,
    this.defaultColor,
    this.labelText,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.maxTextLength,
    this.onChanged, 
    this.obscureText=false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      readOnly: readOnly,
      keyboardType: textType,
      obscureText: obscureText,
      cursorColor: defaultColor,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: defaultColor),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: defaultColor!),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: defaultColor!),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: defaultColor!),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: ColorsTheme.errorColor, width: 5)),
        hintStyle: TextStyle(
          color: defaultColor,
          fontSize: 18,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      maxLength: maxTextLength,
      onChanged: onChanged,
    );
  }
}
