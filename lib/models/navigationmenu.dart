import 'package:flutter/material.dart';
class NavigationList {
  String menu;
  IconData icon;
  int item;


  NavigationList({this.menu, this.icon, this.item});
}
List<NavigationList> navigationItems = [
  NavigationList(menu:"Home",icon: Icons.home, item: 0),
  NavigationList(menu:"Add Property",icon: Icons.add_business,item: 1),
  NavigationList(menu:"Favorites",icon: Icons.favorite,item: 2),
];