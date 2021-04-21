import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/models/amenities.dart';
import 'package:room_finder/models/college.dart';
import 'package:room_finder/models/property.dart';
import 'package:room_finder/utils/apicalls.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:room_finder/utils/commonfunctions.dart';
import 'package:room_finder/utils/theme.dart';

class PropertyForm extends StatefulWidget {
  @override
  _PropertyFormState createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  List<Amenities> amenitiesList = <Amenities>[];
  List<College> collegesList = <College>[];
  Property property = new Property();
  bool availableAmenities = false;
  bool _isloading = true;
  String message = 'Loading';
  final _formKey = GlobalKey<FormState>();
  final addrfirstline = new TextEditingController();
  final areaController = new TextEditingController();
  final cityController = new TextEditingController();
  final provinceController = new TextEditingController();
  final postalcodeController = new TextEditingController();
  final rentController = new TextEditingController();
  College _selectedCollege;
  var selectedAmenitiesId = {};
  List<DropdownMenuItem<College>> _dropDownCollegeItems;
  setAmenities() async {
    amenitiesList = await getAmenities();
    print(amenitiesList);
    setState(() {
      availableAmenities = true;
    });
  }

  setColleges() async {
    collegesList = await getColleges();
    _dropDownCollegeItems = buildCollegeDropDown(collegesList);
    _selectedCollege = _dropDownCollegeItems[0].value;
    property.collegeid = _dropDownCollegeItems[0].value.collegeid;
    setState(() {});
  }

  List<DropdownMenuItem<College>> buildCollegeDropDown(
      List<College> collegeList) {
    List<DropdownMenuItem<College>> items = List();
    for (College college in collegeList) {
      items.add(
        DropdownMenuItem(
          value: college,
          child: Text(college.collegename),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(College college) async {
    property.collegeid = college.collegeid;
    setState(() {
      _selectedCollege = college;
    });
  }

  void setData() async {
    await setAmenities();
    await setColleges();
    setState(() {
      _isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isloading?Center(child: Container(color: Colors.white70 ,child: _progressIndicator(message))):Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Address First Line',
                  labelText: 'Address First Line',
                  helperText: '*Required',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                controller: addrfirstline,
                onChanged: (value) {
                  property.addressFirstLine = addrfirstline.text;
                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Address First Line';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Area',
                        labelText: 'Area',
                        helperText: '*Required',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      controller: areaController,
                      onChanged: (value) {
                        property.area = areaController.text;
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid Area';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'City',
                        labelText: 'City',
                        helperText: '*Required',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      controller: cityController,
                      onChanged: (value) {
                        property.city = cityController.text;
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid City';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Province',
                        labelText: 'Province',
                        helperText: '*Required',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      controller: provinceController,
                      onChanged: (value) {
                        property.province = provinceController.text;
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid Province';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Postal Code',
                        labelText: 'Postal Code',
                        helperText: '*Required',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      controller: postalcodeController,
                      onChanged: (value) {
                        property.postalcode = postalcodeController.text;
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid PostalCode';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Rent',
                  labelText: 'Rent',
                  helperText: '*Required',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                controller: rentController,
                onChanged: (value) {
                  property.rent = int.parse(rentController.text);
                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Rent';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'College',
                    style:
                        TextStyle(color: appTheme().primaryColor, fontSize: 18),
                  ),
                  Scrollbar(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconEnabledColor: appTheme().primaryColor,
                          style: TextStyle(color: appTheme().primaryColorDark),
                          underline: Container(
                            height: 2,
                            color: Colors.blueGrey,
                          ),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          value: _selectedCollege,
                          items: _dropDownCollegeItems,
                          onChanged: onChangeDropdownItem,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Select Amenities',
                style: TextStyle(color: appTheme().primaryColor, fontSize: 18),
              ),
              Visibility(
                visible: availableAmenities,
                child: Container(
                  height: 300,
                  child: ListView(
                    children: amenitiesList.map((Amenities key) {
                      return CheckboxListTile(
                        activeColor: appTheme().accentColor,
                        title: Text(key.amenityName,style: TextStyle(color: appTheme().primaryColor),),
                        value: selectedAmenitiesId.keys
                                .toList()
                                .contains(key.amenityId)
                            ? true
                            : false,
                        onChanged: (bool value) {
                          if (value) {
                            setState(() {
                              selectedAmenitiesId.putIfAbsent(
                                  key.amenityId, () => key);
                            });
                            print(selectedAmenitiesId.keys);
                          } else {
                            setState(() {
                              selectedAmenitiesId.remove(key.amenityId);
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        padding: EdgeInsets.only(left:30,top: 10,bottom: 10,right: 30),
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isloading = true;
                              message = 'Uploading';
                            });
                            String displaymessage = await addProperties(property);
                            setState(() {
                              _isloading = false;
                            });
                            _formKey.currentState.reset();
                            displayMessage(displaymessage, context);
                          }
                        },
                        child: Text('Submit',style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,letterSpacing: 1.0),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
}
