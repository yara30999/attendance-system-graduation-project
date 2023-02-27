import 'package:flutter/material.dart';

const kSearchField = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
  hintText: 'Search class....',
  hintStyle: TextStyle(
      color: Color(0xff074e79), fontSize: 14.0, fontFamily: 'poppins'),
  prefixIcon: Icon(Icons.search),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide.none,
  ),
);

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
    borderSide:
        BorderSide(color: Color.fromARGB(255, 114, 114, 114), width: 1.5),
  ),
);
