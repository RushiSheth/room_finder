import 'package:flutter/material.dart';
import 'package:room_finder/utils/theme.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkloginstate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginStatus = prefs.getBool('loginstatus') ?? false;
    if(loginStatus){
      Navigator.pushReplacementNamed(context, '/home');
    }
    else{
      Navigator.pushReplacementNamed(context, '/login');
    }

  }
  void initState(){
    super.initState();
    Timer(Duration(seconds: 10),(){ checkloginstate();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: 30,child: Text('Powered by ICT Department',style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white70,backgroundColor: Colors.transparent,letterSpacing: 1.0),),),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
              child: Text('Room Finder!',style: TextStyle(color: appTheme().accentColor),)
              )
          ),
        );
  }
}
