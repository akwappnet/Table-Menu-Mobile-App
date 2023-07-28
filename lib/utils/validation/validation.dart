import 'package:flutter/cupertino.dart';

import '../../app_localizations.dart';

String? emailValidator(BuildContext context,String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);

  if (value!.isEmpty) {
    return AppLocalizations.of(context).translate('field_must_filled');
  } else if (!regex.hasMatch(value)) {
    return AppLocalizations.of(context).translate('valid_email_errror_message');
  }
  return null;
}

String? passwordValidator(BuildContext context,String? value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);

  if (value!.isEmpty) {
    return AppLocalizations.of(context).translate('field_must_filled');
  } else if (!regex.hasMatch(value)) {
    return AppLocalizations.of(context).translate('strong_password_errror_message');
  }
  return null;
}

String? phoneValidator(BuildContext context,String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return AppLocalizations.of(context).translate('field_must_filled');
  }
  else if (!regExp.hasMatch(value)) {
    return AppLocalizations.of(context).translate('valid_phone_no_error_message');
  }
  return null;
}

String? validateName(BuildContext context,String? value) {
  if (value!.isEmpty){
    return AppLocalizations.of(context).translate('field_must_filled');
  }else if (value.length < 3) {
    return AppLocalizations.of(context).translate('valid_name_error_message');
  } else {
    return null;
  }
}

String? validateField(BuildContext context,String? value) {
 if (value!.length > 100) {
    return AppLocalizations.of(context).translate('100_character_limit_error_message');
  } else {
    return null;
  }
}

String? validateDiscountCode(BuildContext context,String? value) {
  const pattern = r'^[a-zA-Z0-9_]+$';
  final regex = RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return AppLocalizations.of(context).translate('invalid_coupon_code_error_message');
  } else {
    return null;
  }
}


String? cardValidator(BuildContext context,String? value) {
  String patttern = r'^\d{16}$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return AppLocalizations.of(context).translate('field_must_filled');
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid card number';
  }
  return null;
}




String? expiryDateValidation(BuildContext context,String? value) {
  String patttern = r'^(0[1-9]|1[0-2])\/(\d\d\d\d)$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return AppLocalizations.of(context).translate('field_must_filled');
  }
  else if (!regExp.hasMatch(value)) {
    return AppLocalizations.of(context).translate('valid_date_validation_error_message');
  }
  return null;
}


String? cvvValidation(BuildContext context,String? value) {
  String patttern = r'^\d{3,4}$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return AppLocalizations.of(context).translate('field_must_filled');
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid cvv';
  }
  return null;
}


String? validateNotNull(BuildContext context,String? value) {
  if (value!.isEmpty){
    return AppLocalizations.of(context).translate('field_must_filled');
  }else {
    return null;
  }
}



