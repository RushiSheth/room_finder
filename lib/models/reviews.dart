
import 'dart:convert';

Reviews reviewsFromJson(String str) => Reviews.fromJson(json.decode(str));

String reviewsToJson(Reviews data) => json.encode(data.toJson());

class Reviews {
  Reviews({
    this.dateadded,
    this.propertyid,
    this.reviewid,
    this.reviewtext,
    this.userid,
    this.username,
  });

  String dateadded;
  int propertyid;
  int reviewid;
  String reviewtext;
  int userid;
  String username;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    dateadded: json["dateadded"],
    propertyid: json["propertyid"],
    reviewid: json["reviewid"],
    reviewtext: json["reviewtext"],
    userid: json["userid"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "dateadded": dateadded,
    "propertyid": propertyid,
    "reviewid": reviewid,
    "reviewtext": reviewtext,
    "userid": userid,
    "username": username,
  };
}
