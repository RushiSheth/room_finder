import 'dart:convert';
import  'package:http/http.dart'as http;
import 'package:room_finder/models/amenities.dart';
import 'package:room_finder/models/college.dart';
import 'package:room_finder/models/property.dart';
import 'package:room_finder/models/reviews.dart';
import 'package:room_finder/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<int> authUser(String username,String password) async {
  SharedPreferences  preferences =  await SharedPreferences.getInstance();
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
      preferences.setInt('userId', user.userid);
      preferences.setString('Username', user.username);
      preferences.setString('Usertype', user.usertype);
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
Future<List<Amenities>> getAmenities() async {
  http.Response response = await http.get(
    'https://roomfinderapi.herokuapp.com/getamenities',
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
      var amenitiesMapList = propertyJson;
      int count = amenitiesMapList.length;
      List<Amenities> amenitiesList = List<Amenities>();
      for (int i = 0; i < count; i++) {
        amenitiesList.add(Amenities.fromJson(amenitiesMapList[i]));
      }
      print(amenitiesList);
      return amenitiesList;
    }
  }

  else{
    throw Exception('Unable to Validate User');
  }

}
Future<List<College>> getColleges() async {
  http.Response response = await http.get(
    'https://roomfinderapi.herokuapp.com/colleges',
  );
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Authentication Failed"){
      throw Exception('Something Went Wrong');
    }
    else{

      var collegeJson = json.decode(rawResponse);
      print(collegeJson);
      var collegesMapList = collegeJson;
      int count = collegesMapList.length;
      List<College> collegeList = List<College>();
      for (int i = 0; i < count; i++) {
        collegeList.add(College.fromJson(collegesMapList[i]));
      }
      print(collegeList);
      return collegeList;
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

Future<List<Property>> getFavorites() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int userid = preferences.getInt('userId');
  Property property = new Property();
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/getFavorites',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'userid': userid,
      }));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "No Favorites Added"){
      List<Property> propertyList = List<Property>();
      return propertyList;
    }
    else{
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
    throw Exception('Unable to get Favorites');
  }

}


Future<String> addFavorites(int propertyId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int userid = preferences.getInt('userId');
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/addfavorites',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'userid': userid,
        'propertyid': propertyId,
      }));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Favorites added successfully!"){
     return 'Added to Favorites';
    }
    else{
      return 'Already added to Favorites';
    }
  }

  else{
    throw Exception('Unable to get Favorites');
  }

}

Future<List<Reviews>> getReviews(int propertyId) async {
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/getReviews',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'propertyid': propertyId,
      }));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "No Reviews Added"){
      List<Reviews> reviewList = List<Reviews>();
      return reviewList;
    }
    else{
      var reviewJson= json.decode(rawResponse);
      print(reviewJson);
      var reviewMapList = reviewJson;
      int count = reviewMapList.length;
      List<Reviews> reviewList = List<Reviews>();
      for (int i = 0; i < count; i++) {
        reviewList.add(Reviews.fromJson(reviewMapList[i]));
      }
      print(reviewList);
      return reviewList;
    }
  }

  else{
    throw Exception('Unable to get Reviews');
  }

}

Future<String> addReviews(String reviewtext,int propertyId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int userid = preferences.getInt('userId');
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/addreviews',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userid': userid,
        'propertyid': propertyId,
        'reviewtext': reviewtext,
      }));
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Thankyou for your Review!"){
      return 'Thankyou for your Review!';
    }
    else{
      return 'Review updated successfully';
    }
  }

  else{
    throw Exception('Unable to get Favorites');
  }

}

Future<String> addProperties(Property property) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int userid = preferences.getInt('userId');
  property.userid = userid;
  print(propertyToJson(property));
  http.Response response = await http.post(
      'https://roomfinderapi.herokuapp.com/addproperty',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: propertyToJson(property),
  );
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Property added successfully!"){
      return 'Property added';
    }
    else{
      return 'Something went wrong';
    }
  }

  else{
    throw Exception('Something went wrong');
  }

}

Future<String> removeFavorites(Property property) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int userid = preferences.getInt('userId');
  print(jsonEncode(<String, int>{
    'userid': userid,
    'propertyid':property.propertyid,
  }));
  http.Response response = await http.post(
    'https://roomfinderapi.herokuapp.com/deleteFavorites',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },

    body: jsonEncode(<String, int>{
      'userid': userid,
      'propertyid':property.propertyid,
    }),
  );
  if(response.statusCode == 200){
    var rawResponse =  response.body;
    print(jsonDecode(rawResponse));
    if(jsonDecode(rawResponse) == "Favorites deleted"){
      return 'Favorites Removed';
    }
    else{
      return 'Something went wrong';
    }
  }

  else{
    throw Exception('Something went wrong');
  }

}




