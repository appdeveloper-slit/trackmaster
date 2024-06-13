// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimension.dart';

class Sty {
  TextStyle microText = TextStyle(
    fontFamily: 'poppins',
    fontSize: 12.0,
  );
  TextStyle smalltext = TextStyle(
    fontFamily: 'poppins',
    fontSize: 14.0,
  );
  TextStyle mediumtext = TextStyle(
    fontFamily: 'poppins',
    fontSize: 16.0,
  );
  TextStyle largetext = TextStyle(
    fontFamily: 'poppins',
    fontSize: 20.0,
  );

    InputDecoration textFieldOutlineStyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: Clr().Primarycolor,width: 0.4
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  );

 InputDecoration TextFormFieldOutlineDarkStyle = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(
      horizontal: Dim().d14,
      vertical: Dim().d12,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffD1D1D1),
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().Primarycolor,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    errorStyle: TextStyle(
      fontFamily: 'Mulish',
      letterSpacing: 0.5,
      color: Colors.red,
      fontSize: 14.0,
    ),
  );

  

}
