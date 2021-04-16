import 'package:flutter/material.dart';

ThemeData appTheme(){
  // TextTheme _textTheme(TextTheme textTheme){
  //   return textTheme.copyWith(
  //       headline: textTheme.headline.copyWith(
  //         fontFamily: 'SourceSansPro',
  //         fontWeight: FontWeight.w600,
  //         color: Color(0xff344955),
  //
  //       ),
  //       title: textTheme.title.copyWith(
  //         fontFamily: 'SourceSansPro',
  //         color: Color(0xff344955),
  //       ),
  //       display1: textTheme.display1.copyWith(
  //         fontFamily: 'NotoSans',
  //         color: Color(0xff344955),
  //         fontSize: 16,
  //
  //       )
  //
  //   );
  // }
  final ThemeData themeData = ThemeData.light();
  final FloatingActionButtonThemeData fabdata = FloatingActionButtonThemeData();
  final ButtonThemeData buttonThemeData = ButtonThemeData();
  final IconThemeData iconThemeData =IconThemeData(
  );
  return themeData.copyWith(

    // textTheme: _textTheme(themeData.textTheme),
    unselectedWidgetColor: Color(0xff4A6572),
    primaryColor: Color(0xff344955),
    indicatorColor: Color(0xff232f34),
    disabledColor: Color(0xff4A6572),
    buttonTheme: buttonThemeData.copyWith(buttonColor: Color(0xffF9AA33),),
    iconTheme: iconThemeData.copyWith(color: Color(0xff344955),),
    floatingActionButtonTheme: fabdata.copyWith(
      backgroundColor: Color(0xffF9AA33),
    ),
    accentColor: Color(0xffF9AA33),
    primaryColorDark: Color(0xff232f34),
    primaryColorLight: Color(0xff4A6572),
  );
}