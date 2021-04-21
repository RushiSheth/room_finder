import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/screens/propertydetails.dart';
import 'package:room_finder/utils/apicalls.dart';
import 'package:room_finder/models/property.dart';
import 'package:room_finder/utils/theme.dart';
import 'package:room_finder/utils/commonfunctions.dart';

final List images = [
  "https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom1.jpg?alt=media&token=571619f6-4a14-4e08-9284-fba9bbc50a05",
"https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom2.jpg?alt=media&token=e931349d-b4e0-4948-bb4c-64a1f5cd49a1",
"https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom3.jpg?alt=media&token=f96c3409-ec59-4369-a505-e5f4916f02d7",
"https://firebasestorage.googleapis.com/v0/b/livvn-2c605.appspot.com/o/Properties%2Froom4.jpg?alt=media&token=48559833-e2e0-4f91-a30b-8656ed8ac30a",
];
class PropertyView extends StatefulWidget {
  @override
  _PropertyViewState createState() => _PropertyViewState();
}

class _PropertyViewState extends State<PropertyView> {
  String searchText;
  List<Property> propertyList = List<Property>();
  List<Property> filterPropertyList = List<Property>();
  Future<List<Property>> getPropertyList(String text) async {
    if(propertyList.isEmpty){
      propertyList = await getProperties();
    }
    if(text==null){
      return propertyList;
    }
    else{
      text = text.toLowerCase();
      filterPropertyList = propertyList.where((property) {
        var collegeName  = property.collegename.toLowerCase();
        return collegeName.contains(text);
      }).toList();

      return filterPropertyList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(left: 5,right: 5),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0)
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by College",
                    border: InputBorder.none,
                    icon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  ),
                  onChanged: (text){
                    setState(() {
                      searchText = text;
                    });
                  },
                ),

              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: getPropertyList(searchText),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.data==null){
                        return Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                LinearProgressIndicator(
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(height: 10,),
                                Text('Fetching Properties',style: Theme.of(context).textTheme.overline.copyWith(fontSize: 12),)
                              ],
                            ),
                          ),
                        );
                      }
                      else if(snapshot.hasError){
                        return Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Network Error!',style: Theme.of(context).textTheme.overline.copyWith(fontSize: 12),)
                              ],
                            ),
                          ),
                        );
                      }
                      else if(snapshot.data.length==0){
                        return Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('No Data Availaible',style: Theme.of(context).textTheme.overline.copyWith(fontSize: 12),)
                              ],
                            ),
                          ),
                        );
                      }
                      else{
                        return Column(
                        children: <Widget>[
                          Container(
                            child: Text('Available Properties: '+snapshot.data.length.toString()),
                            margin: EdgeInsets.only(top: 5,bottom: 5),
                          ),
                          Expanded(
                            child: Scrollbar(
                              child: ListView.builder(itemCount: snapshot.data.length, itemBuilder: (BuildContext context,int index){
                                return InkWell(
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
                                              Image.network(
                                                images[index%4],
                                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child: CircularProgressIndicator(
                                                      value: loadingProgress.expectedTotalBytes != null
                                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
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
                                                  child: Text('\$' + snapshot.data[index].rent.toString()),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(snapshot.data[index].addressFirstLine, style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  color: appTheme().primaryColor,
                                                ),),
                                                SizedBox(height: 5.0,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(snapshot.data[index].area + ',' + snapshot.data[index].city + ',' + snapshot.data[index].province),
                                                    Text('Near '+snapshot.data[index].collegename),
                                                  ],
                                                ),
                                                SizedBox(height: 10.0,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.star, color: appTheme().accentColor,),
                                                    Icon(Icons.star, color: appTheme().accentColor,),
                                                    Icon(Icons.star, color: appTheme().accentColor,),
                                                    Icon(Icons.star, color: appTheme().accentColor,),
                                                    Icon(Icons.star, color: appTheme().accentColor,),
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
                                  onTap: (){
                                    print(snapshot.data[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PropertyDetails(property: snapshot.data[index],image: images[index%2],),
                                      ),
                                    );
                                  },

                                );
                              },
                              ),
                            ),
                          ),
                        ],
                      );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
