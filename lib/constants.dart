import 'package:flutter/material.dart';


const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 114, 114, 114), width: 1.5),
  ),
);
