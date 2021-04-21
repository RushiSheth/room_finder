import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class listpage extends StatefulWidget {
  @override
  _listpageState createState() => _listpageState();
}

class _listpageState extends State<listpage> {
  List<model> data = [
    model(id: 1, name: "jemis"),
    model(id: 2, name: "rushi"),
    model(id: 3, name: "mahek"),
    model(id: 4, name: "yash"),
  ];
  var ans = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          children: data.map((model key) {
            return CheckboxListTile(
              title: Text(key.name),
              value: ans.keys.toList().contains(key.id) ? true : false,
              onChanged: (bool value) {
                if (value) {
                  setState(() {
                    ans.putIfAbsent(key.id, () => key);
                  });
                  print(ans.values);
                  
                } else {
                  setState(() {
                    ans.remove(key.id);
                  });
                   print(ans.values);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class model {
  String name;
  int id;
  model({this.id, this.name});
}
