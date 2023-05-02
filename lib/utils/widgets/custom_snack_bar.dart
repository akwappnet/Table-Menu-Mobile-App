import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showsnackbar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content),),
  );
}