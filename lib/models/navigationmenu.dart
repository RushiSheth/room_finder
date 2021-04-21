import 'package:flutter/material.dart';
class NavigationList {
  String menu;
  IconData icon;
  int item;


  NavigationList({this.menu, this.icon, this.item});
}
List<NavigationList> navigationItems = [
  NavigationList(menu:"Home",icon: Icons.home, item: 0),
  NavigationList(menu:"Favorites",icon: Icons.favorite,item: 1),
  NavigationList(menu:"Add Property",icon: Icons.add_business,item: 2),
  NavigationList(menu:"My Properties",icon: Icons.home_work_outlined,item: 3),

];