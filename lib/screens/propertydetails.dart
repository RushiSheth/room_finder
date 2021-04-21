import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_finder/models/property.dart';
import 'package:room_finder/models/reviews.dart';
import 'package:room_finder/utils/apicalls.dart';
import 'package:room_finder/utils/theme.dart';
import 'package:room_finder/utils/commonfunctions.dart';

class PropertyDetails extends StatefulWidget {
  PropertyDetails({
    this.property,
    this.image,
  });
  final Property property;
  final String image;

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  bool _loading = false;
  String message = 'None';
  final _reviewController = new TextEditingController();
  List<Reviews> reviewList = List<Reviews>();
  Future<List<Reviews>> getReviewsList(int i) async {
    if (reviewList.isEmpty) {
      reviewList = await getReviews(widget.property.propertyid);
    }
    else if(i == 0)
      {
        reviewList = await getReviews(widget.property.propertyid);
      }
    return reviewList;
  }

  @override
  Widget build(BuildContext context) {
    // final Property property = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black26),
            height: 400,
            child: Image.network(
              widget.image,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.property.addressFirstLine,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        "5/5 reviews",
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      color: Colors.redAccent,
                      icon: Icon(Icons.favorite),
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                          message = 'Updating';
                        });
                        String displaymessage =
                            await addFavorites(widget.property.propertyid);
                        setState(() {
                          _loading = false;
                          message = 'Updating';
                        });
                        displayMessage(displaymessage, context);
                      },
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: appTheme().primaryColorDark,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: appTheme().primaryColorDark,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: appTheme().primaryColorDark,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: appTheme().primaryColorDark,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: appTheme().primaryColorDark,
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.location_on,
                                      size: 16.0,
                                      color: Colors.grey,
                                    )),
                                    TextSpan(
                                        text: widget.property.area +
                                            ' ' +
                                            widget.property.city +
                                            ' ' +
                                            widget.property.province)
                                  ]),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14.0),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "\$" + widget.property.rent.toString(),
                                style: TextStyle(
                                    color: appTheme().primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "/per month",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: appTheme().accentColor,
                          textColor: Colors.white,
                          child: Text(
                            "Add Review",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          onPressed: reviewDialog,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Description".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      // Text(
                      //   "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?", textAlign: TextAlign.justify, style: TextStyle(
                      //     fontWeight: FontWeight.w300,
                      //     fontSize: 14.0
                      // ),),
                      Text(
                        "Reviews",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.0),
                      ),
                      Container(
                        height: 300,
                        alignment: Alignment.topRight,
                        child: FutureBuilder(
                          future: getReviewsList(0),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Fetching Reviews',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline
                                            .copyWith(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Container(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Network Error!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline
                                            .copyWith(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else if (snapshot.data.length == 0) {
                              return Container(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'No Reviews Available',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline
                                            .copyWith(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          elevation: 0,
                                          // margin: EdgeInsets.O(5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  snapshot
                                                      .data[index].reviewtext,
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                      snapshot
                                                          .data[index].username,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          .copyWith(
                                                              color: Color(
                                                                  0xff4A6572)),
                                                    ),
                                                    // Text(
                                                    //   // DateFormat.yMMMd().format(snapshot.data[index].dateadded),
                                                    //   style: Theme.of(context).textTheme.overline.copyWith(color: Color(0xff4A6572)),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Visibility(
                visible: _loading,
                child: Container(
                  color: Colors.white70,
                  child: _progressIndicator(message),
                )),
          )
        ],
      ),
    );
  }

  Widget _progressIndicator(String message) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text(
            message + '',
            style: Theme.of(context).textTheme.caption.copyWith(
                letterSpacing: 1.0, color: appTheme().primaryColorDark),
          ),
        ],
      ),
    );
  }

  reviewDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.rate_review_rounded,
                  color: appTheme().primaryColor,),
                SizedBox(width: 10,),
                Text(
                  'Review Here',style: TextStyle(color: appTheme().primaryColor),
                ),
              ],
            ),
            elevation: 1.0,

            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            content: TextField(
              maxLength: 250,
              enableSuggestions: true,
              controller: _reviewController,
              cursorColor: appTheme().primaryColorDark,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xff4A6572))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xff4A6572))),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xff4A6572))),
              ),
            ),
//        backgroundColor: Colors.lime[50],
            actions: <Widget>[
              FlatButton(
                  child: Center(
                    child:
                        Text('Cancel', style: TextStyle(color: appTheme().primaryColorDark,wordSpacing: 1.0)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                color: appTheme().accentColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: EdgeInsets.only(left:30,top: 10,bottom: 10,right: 30),
                child: Center(
                  child: Text('Submit',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white,wordSpacing: 1.0)),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if(_reviewController.text.isEmpty || _reviewController.text.length < 5){
                    displayMessage('Inappropriate Review', context);
                  }
                  else {
                    addReview(_reviewController.text);
                  }

                },
              ),
            ],
          );
        });
  }
  addReview(String reviewText) async {
    setState(() {
      _loading = true;
      message = 'Adding Review';
    });
    String apimessage = await addReviews(reviewText, widget.property.propertyid);
    await getReviewsList(0);
    setState(() {
      _loading = false;
      message = 'Adding Review';
    });
    displayMessage(apimessage, context);

  }
}
