import 'package:flutter/material.dart';

class CustomTextFormField {
  TextFormField getCustomEditTextArea(
      {
        required String labelValue,
        required String hintValue,
        required TextEditingController controller,
        TextInputType? keyboardType,
        required Icon prefixicon,
         TextStyle? textStyle,
        IconButton? iconButton,
        required bool obscuretext,
        required FormFieldSetter onchanged,
        required String? Function(String?)? validator,
         int? maxLines,}) {
    TextFormField textFormField = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: textStyle,
      controller: controller,
      onChanged: onchanged,
      obscureText: obscuretext,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: iconButton,
        prefixIcon: prefixicon,
          labelText: labelValue,
          hintText: hintValue,
          labelStyle: textStyle,
          border: const OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(25))),
          // This is the error border
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          )
      ),
    );
    return textFormField;
  }
}