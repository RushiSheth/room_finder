import 'package:flutter/material.dart';
import 'package:room_finder/utils/theme.dart';

final List rooms = [
  {
    "image": "https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom1.jpg?alt=media&token=571619f6-4a14-4e08-9284-fba9bbc50a05",
    "title": "Awesome room near Bouddha"
  },
  {
    "image": "https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom2.jpg?alt=media&token=e931349d-b4e0-4948-bb4c-64a1f5cd49a1",
    "title": "Peaceful Room"
  },
  {
    "image": "https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom3.jpg?alt=media&token=e15c643a-cd23-4877-b7aa-622429be0d2f",
    "title": "Beautiful Room"
  },
  {
    "image": "https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom4.jpg?alt=media&token=f732004b-7f7d-4063-afc6-9d35ca848340",
    "title": "Vintage room near Pashupatinath"
  },
];
class Property extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 180.0,
            backgroundColor: appTheme().primaryColorDark,
            floating: true,
            flexibleSpace: ListView(
              children: <Widget>[
                SizedBox(height: 70.0,),
                Text("Type your College", textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Humber",
                      border: InputBorder.none,
                      icon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                    ),
                  ),
                ),
              ],
            ) ,
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.0,),),
          SliverToBoxAdapter(
            child: _buildCategories(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buildRooms(context,index);
                },
                childCount: 100
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRooms(BuildContext context, int index) {
    var room = rooms[index % rooms.length];
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.network(room['image']),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Icon(Icons.star, color: Colors.grey.shade800,size: 20.0,),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Icon(Icons.star_border, color: Colors.white,size: 24.0,),
                    ),
                    Positioned(
                      bottom: 20.0,
                      right: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        child: Text("\$40"),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(room['title'], style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 5.0,),
                      Text("Bouddha, Kathmandu"),
                      SizedBox(height: 10.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.green,),
                          Icon(Icons.star, color: Colors.green,),
                          Icon(Icons.star, color: Colors.green,),
                          Icon(Icons.star, color: Colors.green,),
                          Icon(Icons.star, color: Colors.green,),
                          SizedBox(width: 5.0,),
                          Text("(220 reviews)", style: TextStyle(color: Colors.grey),)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 100,
    );
  }
}


class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;

  const Category({
    Key key,
    @required this.icon,
    @required this.title,
    this.backgroundColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white,),
            SizedBox(height: 5.0,),
            Text(title, style: TextStyle(
                color: Colors.white
            ))
          ],
        ),
      ),
    );
  }
}