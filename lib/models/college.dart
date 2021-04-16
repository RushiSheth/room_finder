class College {
  int _collegeid;
  String _collegename;
  String _address_first_line;
  String _area;
  String _city;
  String _province;
  String _postalcode;

  int get collegeid => _collegeid;

  set collegeid(int value) {
    _collegeid = value;
  }

  College.withId(this._collegeid, this._collegename, this._address_first_line,
      this._area, this._city, this._province, this._postalcode);

  College(this._collegename, this._address_first_line, this._area, this._city,
      this._province, this._postalcode);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (collegeid != null) {
      map['Id'] = _collegeid;
    }
    map['collegename'] = _collegename;
    map['address_first_line'] = _address_first_line;
    map['area'] = _area;
    map['city'] = _city;
    map['province'] = _province;
    map['postalcode']=_postalcode;
    return map;
  }

  College.fromMapObject(Map<String, dynamic> map) {
    this._collegeid = map['collegeid'];
    this._collegename = map['collegename'];
    this._address_first_line = map['address_first_line'];
    this._area = map['area'];
    this._city= map['city'];
    this._postalcode = map['postalcode'];
  }

  String get collegename => _collegename;

  String get postalcode => _postalcode;

  set postalcode(String value) {
    _postalcode = value;
  }

  String get province => _province;

  set province(String value) {
    _province = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get area => _area;

  set area(String value) {
    _area = value;
  }

  String get address_first_line => _address_first_line;

  set address_first_line(String value) {
    _address_first_line = value;
  }

  set collegename(String value) {
    _collegename = value;
  }
}
