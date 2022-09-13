import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  String? Function(String?)? validator;
  TextEditingController controller;
  String? labelText;
  String? hintText;
  IconData? prefixIcon;
  Widget? suffixIcon;
  Iterable<String>? hints;
  int? maxLines;
  TextFormFieldWidget({ 
    Key? key, 
    required this.validator, 
    required this.controller, 
    this.hintText, 
    this.labelText, 
    this.prefixIcon, 
    this.suffixIcon, 
    this.hints,
    this.maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextFormField(
      validator: validator,
      controller: controller,
      minLines: 1,
      maxLines: maxLines,
      textInputAction: TextInputAction.next,
      style: GoogleFonts.varelaRound(
        textStyle: const TextStyle(
          fontSize: 18,
        )
      ),
      decoration: InputDecoration(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        filled: true,
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 16
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon
      ),
      autofillHints: hints,
    );
  }
}