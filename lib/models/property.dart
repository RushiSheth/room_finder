// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

Property propertyFromJson(String str) => Property.fromJson(json.decode(str));

String propertyToJson(Property data) => json.encode(data.toJson());

class Property {
  Property({
    this.addressFirstLine,
    this.area,
    this.city,
    this.collegeid,
    this.postalcode,
    this.propertyid,
    this.province,
    this.userid,
  });

  String addressFirstLine;
  String area;
  String city;
  int collegeid;
  String postalcode;
  int propertyid;
  String province;
  int userid;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    addressFirstLine: json["address_first_line"],
    area: json["area"],
    city: json["city"],
    collegeid: json["collegeid"],
    postalcode: json["postalcode"],
    propertyid: json["propertyid"],
    province: json["province"],
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "address_first_line": addressFirstLine,
    "area": area,
    "city": city,
    "collegeid": collegeid,
    "postalcode": postalcode,
    "propertyid": propertyid,
    "province": province,
    "userid": userid,
  };
}
