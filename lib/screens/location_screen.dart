import 'package:flutter/material.dart';
import 'package:flutter_clima_app_project/services/weather.dart';
import 'package:flutter_clima_app_project/utilities/constants.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  var Locationdata;
  LocationScreen({@required this.Locationdata});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String weatherIcons;
  String weatherMassage;
  String cityname;
  int temprature;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();

    UPDATE(widget.Locationdata);
  }

  void UPDATE(dynamic data) {
    setState(() {
      int condition = data['weather'][0]['id'];
      double tem = data['main']['temp'] - 273.15;
      this.temprature = tem.toInt();
      cityname = data['name'];
      weatherIcons = weatherModel.getWeatherIcon(condition);
      weatherMassage = weatherModel.getMessage(temprature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var data = await weatherModel.getWeatherdata(
                          conditions: 200, temp: 301.06, name: 'Tokyo');
                      UPDATE(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      this.temprature.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcons️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMassage in ${this.cityname}",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
