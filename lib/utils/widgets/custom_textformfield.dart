import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';

class CustomTextFormField {
  TextFormField getCustomEditTextArea(
      {
        required String labelValue,
        required String hintValue,
        required TextEditingController controller,
        TextInputType? keyboardType,
        Icon? prefixicon,
         TextStyle? textStyle,
        InkWell? icon,
        int? maxLength,
        List<TextInputFormatter>? inputFormatters,
        required bool obscuretext,
        required FormFieldSetter onchanged,
        void Function()? onEditingComplete,
        void Function(String)? onFieldSubmitted,
        FocusNode? focusNode,
        TextInputAction? textInputAction,
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
      maxLength: maxLength,
      focusNode: focusNode,
      inputFormatters : inputFormatters ?? [],
      textInputAction: textInputAction,
      decoration: InputDecoration(
        suffixIcon: icon,
        prefixIcon: prefixicon,
          labelText: labelValue,
          hintText: hintValue,
          labelStyle: textStyle,
          border: const OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS))),
          // This is the error border
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS)),
          )
      ),
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
    );
    return textFormField;
  }
}