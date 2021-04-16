// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.accPassword,
    this.emailaddress,
    this.firstname,
    this.lastname,
    this.phonenumber,
    this.registereddate,
    this.userid,
    this.username,
    this.usertype,
  });

  String accPassword;
  String emailaddress;
  String firstname;
  String lastname;
  int phonenumber;
  String registereddate;
  int userid;
  String username;
  String usertype;

  factory User.fromJson(Map<String, dynamic> json) => User(
    accPassword: json["acc_password"],
    emailaddress: json["emailaddress"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phonenumber: json["phonenumber"],
    registereddate: json["registereddate"],
    userid: json["userid"],
    username: json["username"],
    usertype: json["usertype"],
  );

  Map<String, dynamic> toJson() => {
    "acc_password": accPassword,
    "emailaddress": emailaddress,
    "firstname": firstname,
    "lastname": lastname,
    "phonenumber": phonenumber,
    "registereddate": registereddate,
    "userid": userid,
    "username": username,
    "usertype": usertype,
  };
}
