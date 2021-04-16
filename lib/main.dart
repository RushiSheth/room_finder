import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:room_finder/screens/login.dart';
import 'package:room_finder/screens/propertydetails.dart';
import 'package:room_finder/screens/register.dart';
import 'package:room_finder/screens/home.dart';
import 'package:room_finder/utils/theme.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoomFinder',
      theme: appTheme(),
      home: Home(),
      routes: {
         '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/propertydetails': (context) => PropertyDetails(),
        // '/leaveApplication': (context) => LeaveApplication(),
        // '/expenseVoucher':(context) => ExpenseVoucher(),
        // '/dataScreen':(context)=>DataScreen(),
        // '/inventoryScreen':(context)=>InventoryScreen(),
      },
    );
  }
}
