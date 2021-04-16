import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:room_finder/utils/apicalls.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checked = false;
  bool _isLoading=false;
  bool _userError=false;
  bool _passwordError=false;
  String _message="none";
  final _scaffoldKey= GlobalKey<ScaffoldState>();
  final _usernameText = TextEditingController();
  final _passwordText = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _usernameText.dispose();
    _passwordText.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        Text('Proceed with your',style: Theme.of(context).textTheme.body1.copyWith(color: Color(0xff4A6572),fontSize: 20),),
                        Text('LOGIN',style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xff345955),fontSize: 40,letterSpacing: 1.0),),
                        SizedBox(height: 20,),
                        TextField(
                          controller: _usernameText,
                          decoration: InputDecoration(
                            fillColor: Color(0xff4A6572),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide(color: Color(0xff4A6572))),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide(color: Color(0xff4A6572))),
                            hintText: 'Username',
                            labelText: 'Username',
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide(color: Color(0xff4A6572))),
                            errorText: _userError? 'Invalid Username' : null,
                            prefixIcon: Icon(
                              Icons.person_pin,color: Color(0xff344955),
                            ),
                          ),

                        ),
                        SizedBox(height: 20,),
                        TextField(
                          controller: _passwordText,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide(color: Color(0xff4A6572))),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide(color: Color(0xff4A6572))),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide(color: Color(0xff4A6572))),
                            hintText: 'Password',
                            labelText: 'Password',
                            errorText: _passwordError? 'Invalid Password' : null,
                            prefixIcon: Icon(
                              Icons.lock,color: Color(0xff344955),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Switch(value: checked,
                                  inactiveThumbColor: Color(0xff4A6572),
                                  activeColor: Color(0xff344955).withOpacity(0.8),
                                  onChanged: (value){
                                    setState(() {
                                      checked = value;
                                    });
                                  },),
                                Text('Remember Me')
                              ],
                            ),
                            SizedBox(width: 20,),
                            RaisedButton(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              padding: EdgeInsets.only(left:30,top: 10,bottom: 10,right: 30),
                              onPressed: () async {
                                int i =  _checkInput();
                                if(i==1){
                                  _authenticate(_usernameText.text,_passwordText.text);
                                }


                              },
                              child: Text('LOGIN',style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,letterSpacing: 1.0),),),
                          ],
                        ),
                        Center(
                          child: Visibility(
                              visible: _isLoading,
                              child: _progressIndicator(_message)),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  int _checkInput(){
    if(_usernameText.text.isEmpty){
      setState(() {
        _userError = true;
      });
      return 0;
    }
    else if(_passwordText.text.isEmpty){
      setState(() {
        _passwordError = true;
      });
      return 0;
    }
    else{
      setState(() {
        _userError=false;
        _passwordError=false;
        _isLoading=true;
        _message='Authenticating User';
      });
      return 1;


    }

  }

  void _authenticate(String username,password) async {
    SharedPreferences  preferences =  await SharedPreferences.getInstance();
    final noUserSnackBar = SnackBar(
      content: Text('Invalid Username or Password'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blueGrey[800],
      action: SnackBarAction(textColor: Colors.teal[100],
        label: 'Dismiss', onPressed: (){
          _scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),);
    int i = await authUser(username,password);
    if(i==1){
      print('User Validated');
      preferences.setString('Username', username);
      if(checked){
        preferences.setBool('loginstatus', true);
      }
      setState(() {
        _isLoading=false;
      });
      Navigator.pushReplacementNamed(context, '/home');
    }
    else{
      setState(() {
        _isLoading=false;
      });
      _scaffoldKey.currentState.showSnackBar(noUserSnackBar);
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
