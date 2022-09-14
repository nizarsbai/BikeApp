import 'package:flutter/material.dart';

void nextScreen(context, page) {
  if(page==null)
  {
    return;
  }
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}