import 'package:flutter/material.dart';

//Light Theme
const primary = Color(0xff6cb0f4);
const primaryLight = Color(0xffa1e2ff);
const primaryDark = Color(0xff3181c1);

const FocusColor = Colors.redAccent;
const kBackgroundColor = Color(0xFFF4F5FA);
const secondary = Color(0xffc0bef4);
const secondaryLight = Color(0xfff3f1ff);
const secondaryDark = Color(0xff8f8ec1);
//Dark Theme
const Dark_primary = Color(0xff212121);
const Dark_primaryLight = Color(0xff484848);
const Dark_primaryDark = Color(0xff000000);

const Dark_secondary = Color(0xff630000);
const Dark_secondaryLight = Color(0xff97362a);
const Dark_secondaryDark = Color(0xff3a0000);

final kTextFieldDecoration = InputDecoration(
  hintText: 'Search for items', //default
  // hintStyle: TextStyle(color: Colors.black45),
  //hintText: 'Enter your value', //نص افتراضي اذا ما ستعملنا كوبي في كل استدعاء
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(width: 1.0, color: primary),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide(width: 2.0, color: primaryDark),
  ),
);
// const kTextStyleFavorite = TextStyle(
//   color: Colors.black54,
//   fontSize: 18,
//   fontWeight: FontWeight.w400,
// );
