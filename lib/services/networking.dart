import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetWorking {
  var lat;

  var lon;

  NetWorking({@required this.lat, @required this.lon});

  // int condition=701;
  // double temprature=287.06;
  // String cityname='Pasatiempo';

  dynamic getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=88e764e9c6283a12d5aa5e9d613b360c'));
    var jsonsDataString = await jsonDecode(response.body);
    print(jsonsDataString);
    return jsonsDataString;
  }
}
