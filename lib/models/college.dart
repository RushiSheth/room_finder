

import 'dart:convert';

College collegeFromJson(String str) => College.fromJson(json.decode(str));

String collegeToJson(College data) => json.encode(data.toJson());

class College {
  College({
    this.addressFirstLine,
    this.area,
    this.city,
    this.collegeid,
    this.collegename,
    this.postalcode,
    this.province,
  });

  String addressFirstLine;
  String area;
  String city;
  int collegeid;
  String collegename;
  String postalcode;
  String province;

  factory College.fromJson(Map<String, dynamic> json) => College(
    addressFirstLine: json["address_first_line"],
    area: json["area"],
    city: json["city"],
    collegeid: json["collegeid"],
    collegename: json["collegename"],
    postalcode: json["postalcode"],
    province: json["province"],
  );

  Map<String, dynamic> toJson() => {
    "address_first_line": addressFirstLine,
    "area": area,
    "city": city,
    "collegeid": collegeid,
    "collegename": collegename,
    "postalcode": postalcode,
    "province": province,
  };
}
