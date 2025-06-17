import 'package:flutter/material.dart';

InputDecoration appInputDecoration(String label, BuildContext context) {
  return InputDecoration(
    labelText: label,
    isDense: true,
    focusColor: Theme.of(context).primaryColor,
    contentPadding: EdgeInsets.only(bottom: 4),
    labelStyle: TextStyle(color: Color(0xFF898989), fontSize: 16),
    border:
        UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC4C4C4))),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
    ),
  );
}
