import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

var kDigitalClockStyle = DigitalClock(
    is24HourTimeFormat: false,
    showSecondsDigit: false,
    digitAnimationStyle: Curves.easeInOutSine,
    areaDecoration: const BoxDecoration(color: Colors.transparent),
    areaAligment: AlignmentDirectional.topStart,
    hourMinuteDigitTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20.0, fontFamily: 'poppins'),
    amPmDigitTextStyle: const TextStyle(
        color: Colors.white, fontSize: 0.0, fontFamily: 'poppins'),
    colon: const Text(':',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'poppins')));

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
