import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  const TextFieldComponent(
      {Key? key, required this.hint, required this.myController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600)),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          border: InputBorder.none),
    );
  }
}
