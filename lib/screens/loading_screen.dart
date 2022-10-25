import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({this.citydata});
  String citydata;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.citydata != null) {
      getLocationData(widget.citydata);
    } else {
      getWeatherData();
    }
  }

  void getLocationData(citydata) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$citydata&appid=88e764e9c6283a12d5aa5e9d613b360c'));
    var data = await jsonDecode(response.body);
    print(data);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(Locationdata: data)));
  }

  void getWeatherData() async {
    location Location = await location();
    await Location.getCurrentLocation();
    NetWorking netWorking =
        await NetWorking(lon: Location.Longitude, lat: Location.Latitude);
    var data = await netWorking.getData();
    print(data);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(Locationdata: data)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SpinKitPouringHourGlassRefined(color: Colors.green, size: 50));
  }
}
