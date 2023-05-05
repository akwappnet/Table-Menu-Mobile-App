String? emailValidator(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);

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
  RegExp regex = new RegExp(pattern);

  if (value!.isEmpty) {
    return 'This field must be filled';
  } else if (!regex.hasMatch(value)) {
    return 'Use 8 or more characters with a mix of capital & small letters, \nnumbers & symbols';
  }
  return null;
}

String? phoneValidator(String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (value?.length == 0) {
    return 'Please enter mobile number';
  }
  else if (!regExp.hasMatch(value!)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? validateName(String value) {
  if (value.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}