import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({Key? key, required this.text, this.icon, this.iconButton ,required this.controller}) : super(key: key);
  final String text;
  final Icon? icon;
  final IconButton? iconButton;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: icon,
        suffixIcon: iconButton,
        border: const OutlineInputBorder()
      ),
    );
  }
}
