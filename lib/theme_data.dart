import 'package:flutter/material.dart';

import 'constants.dart';

var themeLight = ThemeData.light().copyWith(
  canvasColor: primaryLight,
  primaryColor: primary, //appbar color
  accentColor: secondary, //secondary color
  selectedRowColor: Dark_primaryDark, //icon color
  scaffoldBackgroundColor: kBackgroundColor,
  cardColor: Colors.white, //card color
  buttonColor: secondaryDark, //button color
  dividerColor: secondaryDark, //divider and listTile and PopMenuDividers color
  bottomAppBarColor: primaryDark,
  sliderTheme: SliderThemeData(
    thumbShape: RoundSliderThumbShape(elevation: 4),
    thumbColor: secondary,
    activeTrackColor: secondaryDark,
    inactiveTrackColor: secondaryLight,
    overlayColor: secondaryLight.withOpacity(0.5),
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
        headline1: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
          color: FocusColor,
        ),
        headline2: TextStyle(fontSize: 14.0, color: Colors.black87),
      ),
);

var themeDark = ThemeData.dark().copyWith(
  canvasColor: Dark_primaryLight, //drawer color
  primaryColor: Dark_primary, //appbar color
  accentColor: Dark_secondary, //secondary color
  selectedRowColor: secondaryLight, //icon color
  scaffoldBackgroundColor: Dark_primaryLight,
  cardColor: Dark_primaryDark, //card color
  sliderTheme: SliderThemeData(
    thumbShape: RoundSliderThumbShape(elevation: 4),
    thumbColor: Dark_secondary,
    activeTrackColor: Dark_secondaryDark,
    inactiveTrackColor: Dark_secondaryLight,
    overlayColor: Dark_secondaryLight.withOpacity(0.5),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(Dark_secondaryLight),
  ),
  buttonColor: Dark_secondaryDark, //button color
  dividerColor: Dark_secondaryLight,
  bottomAppBarColor: Dark_primary, // bottomAppBar Color
  textTheme: ThemeData.dark().textTheme.copyWith(
        headline1: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
          color: FocusColor,
        ),
        headline2: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
);
