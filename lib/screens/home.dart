import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/screens/favorite.dart';
import 'package:room_finder/screens/myproperty.dart';
import 'package:room_finder/screens/propertyform.dart';
import 'package:room_finder/screens/propertylist.dart';
import 'package:room_finder/utils/theme.dart';
import 'package:room_finder/models/navigationmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:room_finder/screens/temp.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _message = 'none';
  int _selectedItem = 0;
  int count = 0;
  bool _visible = true;
  bool _isLoading = false;
  DateTime _dateTime = DateTime.now();
  String username = 'Guest';
  String usertype;
  void _getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('Username');
      usertype = preferences.getString('Usertype');
    });
  }

  void _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('loginstatus', false);
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color(0xff232f34)),
        ),
        drawer: new Drawer(
          child: Container(
            color: Color(0xff344955),
            child: Column(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 4,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          color: appTheme().accentColor,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          username,
                          style: Theme.of(context).textTheme.headline.copyWith(
                              color: Colors.blueGrey[200].withOpacity(0.8),
                              fontSize: 20,
                              letterSpacing: 1.0),
                        ),
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    itemBuilder: (context, counter) {
                      if (navigationItems[counter].item == _selectedItem) {
                        return ListTile(
                          trailing: new Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          ),
                          title: new Text(
                            navigationItems[counter].menu,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 16),
                            softWrap: true,
                          ),
                          leading: new Icon(
                            navigationItems[counter].icon,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          ),
                          onTap: () {
                            setState(() {
                              _selectedItem = navigationItems[counter].item;
                              if (_selectedItem == 3) {
                                _visible = false;
//                                  updateListView();
                              } else {
                                _visible = true;
                              }
                            });
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        if (navigationItems[counter].item < 2) {
                          return ListTile(
                            title: new Text(
                              navigationItems[counter].menu,
                              style: TextStyle(
                                  color: Colors.blueGrey[500],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),
                            leading: new Icon(
                              navigationItems[counter].icon,
                              color: Colors.blueGrey[500],
                              size: 18,
                            ),
                            onTap: () async {
                              setState(() {
                                _selectedItem = navigationItems[counter].item;
                                if (_selectedItem == 3) {
                                  _visible = false;
                                } else {
                                  _visible = true;
                                }
                              });
                              Navigator.pop(context);
                            },
                          );
                        } else if (usertype == 'owner') {
                          return ListTile(
                            title: new Text(
                              navigationItems[counter].menu,
                              style: TextStyle(
                                  color: Colors.blueGrey[500],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),
                            leading: new Icon(
                              navigationItems[counter].icon,
                              color: Colors.blueGrey[500],
                              size: 18,
                            ),
                            onTap: () async {
                              setState(() {
                                _selectedItem = navigationItems[counter].item;
                                if (_selectedItem == 3) {
                                  _visible = false;
                                } else {
                                  _visible = true;
                                }
                              });
                              Navigator.pop(context);
                            },
                          );
                        } else {
                          return null;
                        }
                      }
                    },
                    itemCount: navigationItems.length,
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: Color(0xffF9AA33).withOpacity(0.9),
                      padding: EdgeInsets.only(
                          left: 50, top: 10, bottom: 10, right: 50),
                      child: Text(
                        'LOGOUT',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white, letterSpacing: 1.5),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () async {
                        _logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: getBodyWidget(),
      ),
    );
  }

  Widget getBodyWidget() {
    if (_selectedItem == 0) {
      return PropertyView();
    } else if (_selectedItem == 1) {
      return FavoriteView();
    } else if (_selectedItem == 2) {
      return PropertyForm();
    }
    else if (_selectedItem == 3) {
      return MyProperty();
    }
  }
}
