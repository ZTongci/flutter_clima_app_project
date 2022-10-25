import 'package:geolocator/geolocator.dart';

class location {
  double Latitude;
  double Longitude;

  Future<void> getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      this.Latitude = position.latitude;
      this.Longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
