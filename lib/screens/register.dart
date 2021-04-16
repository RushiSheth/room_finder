import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:room_finder/models/college.dart';
import 'dart:async';
import 'package:room_finder/models/user.dart';
import 'package:room_finder/utils/apicalls.dart';
import 'package:room_finder/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>  {

  var _userType = ['student','owner'];
  var usertype = 'student';
  List<User> userlist;
  String _message = 'None';
  bool _visibleRegisterForm = false;
  bool _visibleSearch = true;
  bool _enable =  true;
  bool _nameError =  false;
  bool _lastNameError = false;
  bool _emailError = false;
  bool _usernameError = false;
  bool _passwordError = false;
  bool _isloading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User user = new User();


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    user.usertype = usertype;
  }
  @override
  void dispose(){
    super.dispose();
    firstNameController.dispose();
    contactNoController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: Container(
//            decoration: BoxDecoration(
//                gradient: LinearGradient(
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomCenter,
//                  colors: [
//                    Colors.lime[50],
//                    Colors.teal[100]
//                  ],
//                )
//            ),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20,top: 10,bottom: 10,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Welcome to',style: Theme.of(context).textTheme.body1.copyWith(color: Color(0xff4A6572),fontSize: 20),),
                    Text('Room Finder',style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xff345955),fontSize: 40,letterSpacing: 1.0),),
                    SizedBox(height: 10,),
                    TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      enabled: _enable,
                      decoration: InputDecoration(
                          hintText: 'Enter Contact Number',
                          labelText: 'Contact Details',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                          icon: Icon(Icons.call)
                      ),
                      controller: contactNoController,
                      onChanged: (value){
                        updateContactNo();
                      },
                    ),
                    Visibility(
                      visible: _visibleSearch,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                color: Colors.transparent,
                                elevation: 0.0,
                                child: Text('CANCEL',style: TextStyle(color: Colors.teal,letterSpacing: 1.0),),
                                onPressed: () async {
                                  await getProperties();
                                  // Navigator.pushReplacementNamed(context,'/home');

                                }
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                color: Colors.teal,
                                child: Text('REGISTER',style: TextStyle(color: Colors.white,letterSpacing: 1.0),),
                                splashColor: Colors.teal[200],
                                onPressed: (){
                                    setState(() {
                                      _isloading = true;
                                      _message = 'Validating Contact Details';
                                    });
                                  _checkContactDuplicate();

                                }
                            ),
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: _visibleRegisterForm,
                      child: Column(
                        children: <Widget>[
                          Form(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('User Type',style: TextStyle(color: Colors.blueGrey),),
                                    DropdownButton<String>(
                                        iconEnabledColor: Colors.blueGrey,
                                        style: TextStyle(color: Colors.blueGrey[600]),
                                        value: usertype,
                                        underline: Container(height: 2,color: Colors.blueGrey,),
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        items: _userType.map((String dropdownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropdownStringItem,
                                            child: Text(dropdownStringItem,style: TextStyle(color: Colors.blueGrey),),
                                          );
                                        }).toList(),
                                        onChanged: (value) {setState(() {
                                          usertype = value;
                                          user.usertype = usertype;
                                        });
                                        }
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter $usertype Name',
                                      labelText: 'Enter $usertype Name',
                                      errorText: _nameError? 'Please Enter Name':null,
                                      helperText: '*Required',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                      icon: Icon(Icons.person)
                                  ),
                                  controller: firstNameController,
                                  onChanged: (value){
                                    user.firstname= firstNameController.text;
                                  },

                                ),
                                SizedBox(height: 10,),

                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Lastname',
                                      labelText: 'Lastname',
                                      errorText: _lastNameError? 'Please Enter the detail':null,
                                      helperText: '*Required',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                      icon: Icon(Icons.person)
                                  ),
                                  controller: lastnameController,
                                  onChanged: (value){
                                    user.lastname = lastnameController.text;
                                  },

                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Email',
                                      labelText: 'Email',
                                      errorText: _emailError? 'Please Enter the Email':null,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                      icon: Icon(Icons.email)
                                  ),
                                  controller: emailController,
                                  onChanged: (value){
                                    user.emailaddress = emailController.text;
                                  },

                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Username',
                                      labelText: 'Username',
                                      errorText: _usernameError? 'Please Enter the username':null,
                                      helperText: '*Required',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                      icon: Icon(Icons.person_pin)
                                  ),
                                  controller: usernameController,
                                  onChanged: (value){
                                    user.username = usernameController.text;
                                  },

                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Password',
                                      labelText: 'Password',
                                      errorText: _passwordError? 'Please Enter the Password':null,
                                      helperText: '*Required',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                      icon: Icon(Icons.lock)
                                  ),
                                  controller: passwordController,
                                  onChanged: (value){
                                    user.accPassword = passwordController.text;
                                  },

                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: RaisedButton(
                                          color: appTheme().accentColor,
                                          child: Text('SUBMIT',style: TextStyle(color: Colors.white),),
                                          splashColor: appTheme().accentColor,
                                          onPressed: (){
                                            setState(() {
                                              _isloading = true;
                                              _message = 'Registering...';
                                            });
                                            _save();

                                          }
                                      ),
                                    ),
                                  ],)

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Visibility(
                    visible: _isloading,
                    child: _progressIndicator(_message)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _checkContactDuplicate() async {
    int i = await checkContact(int.parse(contactNoController.text));
    if(i==0){
      setState(() {
        print('ContactNo Registered');
        _visibleRegisterForm = false;
        _isloading = false;
      });
    }
    else{
      setState(() {
        _enable = false;
        _visibleRegisterForm = true;
        _visibleSearch = false;
        _isloading = false;
      });

    }

  }
  void updateContactNo(){
    var contact = contactNoController.text;
    user.phonenumber = int.parse(contact);
  }
  void _save() async {
    if(firstNameController.text.isEmpty)
    {
      setState(() {
        _nameError = true;
        _lastNameError = false;
        _usernameError = false;
        _passwordError = false;
        _isloading = false;
      });
    }

    else if(lastnameController.text.isEmpty){
      setState(() {
        _nameError = false;
        _usernameError = false;
        _passwordError = false;
        _isloading = false;
        _lastNameError = true;
      });
    }
    // else if(emailController.text.isEmpty){
    //   setState(() {
    //     _emailError = true;
    //   });
    // }
    else if(usernameController.text.isEmpty){
      setState(() {
        _nameError = false;
        _lastNameError = false;
        _passwordError = false;
        _isloading = false;
        _usernameError = true;
      });
    }
    else if(passwordController.text.isEmpty){
      setState(() {
        _nameError = false;
        _lastNameError = false;
        _usernameError = false;
        _isloading = false;
        _passwordError = true;
      });
    }
    else{
      int i = await checkUsername(user);
      if(i==1){
        int temp = await registration(user);
        if(temp == 1){
          print("Registered Successfully");
          setState(() {
            _isloading = false;
          });
          Navigator.pushReplacementNamed(context, '/login');
        }
        else{
          setState(() {
            _isloading = false;
          });
          print("Something went wrong");
        }
      }
      else{
        setState(() {
          _isloading = false;
        });
        print("Username already registered");
      }

      // int result = await helper.insertFarmerVendor(farmerVendor);
      // if(result>0){
      //   print('Entered Succesfully');
      // }

    }


  }
  Widget _progressIndicator(String message){
    return Dialog(backgroundColor: Colors.transparent,elevation: 0.0,child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(width: 10,),
        Text(message+'',style: Theme.of(context).textTheme.caption.copyWith(letterSpacing: 1.0),),
      ],

    ),);

  }
}
