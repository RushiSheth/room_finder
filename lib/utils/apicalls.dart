import 'dart:convert';
import  'package:http/http.dart'as http;
import 'package:room_finder/models/property.dart';
import 'package:room_finder/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> authUser(String username,String password) async {
  User user = new User();
  // var h = jsonEncode(<String, String>{
  //   'username': username,
  //   'password':password,
  // });
  // print(h);
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/auth',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
    'username': username,
        'password':password,
  }));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Authentication Failed"){
      return 0;
    }
    else{
      int start=rawResponse.indexOf("[");
      int end=rawResponse.indexOf("]");
      var jsonResponse= rawResponse.substring(start+1,end);
      print(jsonResponse);
      user = userFromJson(jsonResponse);
      print(user.username);
      print(user.emailaddress);
      return 1;
    }
  }

  else{
    throw Exception('Unable to Validate User');
  }

}
Future<List<Property>> getProperties() async {
  Property property = new Property();
  // var h = jsonEncode(<String, String>{
  //   'username': username,
  //   'password':password,
  // });
  // print(h);
  http.Response response = await http.get(
      'https://roomfinderapi.herokuapp.com/property',
  );
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Authentication Failed"){
      throw Exception('Something Went Wrong');
    }
    else{
      // int start=rawResponse.indexOf("[");
      // int end=rawResponse.indexOf("]");
      // var jsonResponse= rawResponse.substring(start+1,end);
      // print(jsonResponse);
      var propertyJson = json.decode(rawResponse);
      print(propertyJson);
      var propertyMapList = propertyJson;
      int count = propertyMapList.length;
      List<Property> propertyList = List<Property>();
      for (int i = 0; i < count; i++) {
        propertyList.add(Property.fromJson(propertyMapList[i]));
      }
      print(propertyList);
      return propertyList;
    }
  }

  else{
    throw Exception('Unable to Validate User');
  }

}
Future<int> checkContact(int contactNo) async {
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/checkContact',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'contactNo': contactNo,
      }));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Already Exist"){
      return 0;
    }
    else{

      return 1;
    }
  }

  else{
    throw Exception('Something went Wrong');
  }

}

Future<int> checkUsername(User user) async {
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/checkUsername',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
      }));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Already Exist"){
      return 0;
    }
    else{
      return 1;
    }
  }

  else{
    throw Exception('Something went Wrong');
  }

}

Future<int> registration(User user) async {
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/adduser',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: userToJson(user));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "User added"){
      return 1;
    }
    else{

      return 0;
    }
  }

  else{
    throw Exception('Something went Wrong');
  }

}
