import 'package:flutter_clima_app_project/services/location.dart';
import 'package:flutter_clima_app_project/services/networking.dart';

class WeatherModel {
  Future<dynamic> getWeatherdata(
      {int conditions, double temp, String name}) async {
    location Location = location();
    await Location.getCurrentLocation();
    NetWorking netWorking =
        NetWorking(lon: Location.Longitude, lat: Location.Latitude
            // condition:conditions,temprature:temp,cityname:name
            );
    dynamic data = await netWorking.getData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
