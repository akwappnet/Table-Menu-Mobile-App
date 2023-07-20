String? emailValidator(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);

  if (value!.isEmpty) {
    return 'This field must be filled';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter valid email';
  }
  return null;
}

String? passwordValidator(String? value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);

  if (value!.isEmpty) {
    return 'This field must be filled';
  } else if (!regex.hasMatch(value)) {
    return 'Use 8 or more characters with a mix of capital & small letters, \nnumbers & symbols';
  }
  return null;
}

String? phoneValidator(String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return 'This field must be filled';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? validateName(String? value) {
  if (value!.isEmpty){
    return 'This field must be filled';
  }else if (value.length < 3) {
    return 'Name must be more than 2 charater';
  } else {
    return null;
  }
}

String? validateField(String? value) {
 if (value!.length > 100) {
    return '100 character Limit';
  } else {
    return null;
  }
}

String? validateDiscountCode(String? value) {
  const pattern = r'^[a-zA-Z0-9_]+$';
  final regex = RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return 'Invalid discount code.';
  } else {
    return null;
  }
}


String? cardValidator(String? value) {
  String patttern = r'^\d{16}$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return 'This field must be filled';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid card number';
  }
  return null;
}




String? expiryDateValidation(String? value) {
  String patttern = r'^(0[1-9]|1[0-2])\/(\d\d\d\d)$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return 'This field must be filled';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid date';
  }
  return null;
}


String? cvvValidation(String? value) {
  String patttern = r'^\d{3,4}$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return 'This field must be filled';
  }
  else if (!regExp.hasMatch(value)) {
    return 'Please enter valid cvv';
  }
  return null;
}


String? validateNotNull(String? value) {
  if (value!.isEmpty){
    return 'This field must be filled';
  }else {
    return null;
  }
}



