import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/screens/propertylist.dart';
import 'package:room_finder/utils/theme.dart';
import 'package:room_finder/models/navigationmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:room_finder/screens/property.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _message ='none';
  int _selectedItem = 0;
  int count = 0;
  bool _visible = true;
  bool _isLoading = false;
  DateTime _dateTime = DateTime.now();
  String username='Guest';
  void _getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('Username');
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
        appBar: new AppBar(elevation: 0.0,backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: Color(0xff232f34)),),
        drawer: new Drawer(
          child: Container(
            color: Color(0xff344955),
            child: Column(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height/4,
                    margin: EdgeInsets.all(10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          color: appTheme().accentColor,
                          size: 50,
                        ),
                        SizedBox(width: 20,),
                        Text(
                          username,style: Theme.of(context).textTheme.headline.copyWith(color: Colors.blueGrey[200].withOpacity(0.8),fontSize: 20,letterSpacing: 1.0),
                        ),
                      ],
                    )
                ),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    itemBuilder: (context, counter){
                      if(navigationItems[counter].item==_selectedItem){
                        return ListTile(
                          trailing: new Icon(Icons.arrow_forward_ios,color: Theme.of(context).accentColor,size: 20,),
                          title: new Text(navigationItems[counter].menu,style:TextStyle(color:  Theme.of(context).accentColor,fontSize: 16),softWrap: true,),
                          leading: new Icon(navigationItems[counter].icon, color: Theme.of(context).accentColor,size: 20,),
                          onTap:(){
                            setState(() {
                              _selectedItem=navigationItems[counter].item;
                              if(_selectedItem==3){
                                _visible= false;
//                                  updateListView();
                              }
                              else{
                                _visible= true;
                              }

                            });
                            Navigator.pop(context);
                          },
                        );}
                      else{return ListTile(
                        title: new Text(navigationItems[counter].menu,style:TextStyle(color: Colors.blueGrey[500],fontSize: 14,fontWeight: FontWeight.bold),softWrap: true,),
                        leading: new Icon(navigationItems[counter].icon, color: Colors.blueGrey[500],size: 18,),
                        onTap: () async {
                          setState(() {
                            _selectedItem=navigationItems[counter].item;
                            if(_selectedItem==3){
                              _visible= false;
                            }
                            else{
                              _visible= true;
                            }
                          });
                          Navigator.pop(context);
                        },
                      );
                      }

                    },
                    itemCount:navigationItems.length,
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 10,),
                    RaisedButton(color: Color(0xffF9AA33).withOpacity(0.9),
                      padding: EdgeInsets.only(left:50,top: 10,bottom: 10,right: 50),
                      child: Text('LOGOUT',style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,letterSpacing: 1.5),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
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
body: PropertyView()
//         body: Container(
//           alignment: Alignment.topCenter,
//           margin: EdgeInsets.only(bottom: 40),
//           child: Visibility(
//             visible: _visible,
//             replacement: ListView.builder(
//               itemCount: count,
//               itemBuilder: (BuildContext context,int position){
//                 if(count==0){
//                   return Card(child: Text('No Data Available'));
//                 }
//                 else{
//                   return InkWell(
//                     onTap: (){
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => NewsView(newsList[position].newsLink),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       margin: EdgeInsets.all(5),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: <Widget>[
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(newsList[position].newsSource,
//                                   style: Theme.of(context).textTheme.overline.copyWith(color: Color(0xff4A6572)),),
//                                 Text(
//                                   DateFormat.yMMMd().format(_dateTime),
//                                   style: Theme.of(context).textTheme.overline.copyWith(color: Color(0xff4A6572)),)
//                               ],
//                             ),
//                             SizedBox(height: 10,),
//                             Text(newsList[position].newsTitle,style: Theme.of(context).textTheme.display1,textAlign: TextAlign.left,),
//                             SizedBox(height: 10,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 IconButton(icon: Icon(Icons.delete),tooltip: 'Delete ',autofocus: true,
//                                   onPressed: () async {
//                                     databaseHelper.deleteWatchLaterNews(newsList[position].uniqueId);
//                                     await updateListView();
//                                     setState(() {
//
//                                     });
//                                   },
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//             child: Stack(
//               children: <Widget>[
//                 ListView.builder(
//                   itemCount:newsItems.length,
//                   itemBuilder: (context, counter){
//                     if(newsItems[counter].itemType==_selectedItem){
//                       return InkWell(
//                         onTap: (){
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => NewsView(newsItems[counter].link),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           margin: EdgeInsets.all(5),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: <Widget>[
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Text(newsItems[counter].source,
//                                       style: Theme.of(context).textTheme.overline.copyWith(color: Color(0xff4A6572)),),
//                                     Text(
//                                       DateFormat.yMMMd().format(_dateTime),
//                                       style: Theme.of(context).textTheme.overline.copyWith(color: Color(0xff4A6572)),)
//                                   ],
//                                 ),
//                                 SizedBox(height: 10,),
//                                 Text(newsItems[counter].title,style: Theme.of(context).textTheme.display1,textAlign: TextAlign.left,),
//                                 SizedBox(height: 10,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: <Widget>[
// //                                     IconButton(icon: Icon(Icons.bookmark),tooltip: 'Add to Watch Later',autofocus: true,
// //                                       onPressed: () async {
// //
// //
// //                                       },),
//                                     RaisedButton(
//                                       onPressed: () async {
//                                         setState(() {
//                                           _isLoading = true;
//                                           _message = 'Adding to Watch Later';
//                                         });
//                                         await Future.delayed(Duration(seconds: 2));
//                                         news = News(newsItems[counter].source,newsItems[counter].title,newsItems[counter].link,_dateTime.toString(),newsItems[counter].id);
//                                         int i = await databaseHelper.getNewsCount(newsItems[counter].id);
//                                         if(i==0){
//                                           databaseHelper.insertNews(news);
//                                         }
//                                         await updateListView();
//                                         setState(() {
//                                           _isLoading = false;
//                                         });
//                                       },
//                                       elevation: 0,
//                                       splashColor: Theme.of(context).accentColor,
//                                       color: Colors.transparent,child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                                       children: <Widget>[
//                                         Icon(Icons.bookmark,size: 16,),
//                                         SizedBox(width: 10,),
//                                         Text('Read Later',style: Theme.of(context).textTheme.button.copyWith(letterSpacing: 1.0,fontSize: 10),)
//                                       ],
//                                     ),)
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                     else{
//                       return SizedBox(height: 0,);
//                     }
//
//                   },
//                 ),
//                 Visibility(
//                   visible: _isLoading,
//                   child: Container(
//                     color: Colors.white70,
//                     alignment: Alignment.center,
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           CircularProgressIndicator(),
//                           SizedBox(width: 10,),
//                           Text(_message,style: Theme.of(context).textTheme.title.copyWith(color: Theme.of(context).primaryColorDark,fontSize: 12,letterSpacing: 1.0),),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
      ),
    );
  }

  // void updateListView(){
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((database){
  //     Future<List<News>> newsListFuture = databaseHelper.getNewsList();
  //     newsListFuture.then((newsList){
  //       setState(() {
  //         this.newsList = newsList;
  //         this.count = newsList.length;
  //       });
  //     });
  //   });
  // }
}
