import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quickdeed/Models/current_user.dart';

class LocationHandler {

  LocationHandler();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromLatLng(Position pos) async {
    List<Placemark> placemark = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark place = placemark[0];
    return '${place.street}, ${place.subLocality},${place.locality},${place.postalCode}';
  }

  Future<LocationDTO> getUserLocation() async {

    Position pos = await _determinePosition();
    String addr = await getAddressFromLatLng(pos);
    return
      LocationDTO(address: addr ,
          lattitude: pos.latitude,
          longitude: pos.longitude
      );
  }

  String getUserDistance(num sLat ,num sLng , num eLat , num eLng){
    double s_lat = double.parse(sLat.toString());
    double s_lng = double.parse(sLng.toString());
    double e_lat = double.parse(eLat.toString());
    double e_lng = double.parse(eLng.toString());
    double distanceInMeters = Geolocator.distanceBetween(s_lat , s_lng , e_lat, e_lng);
    double distanceInKms =  distanceInMeters / 1000;
    return distanceInKms.ceil().toString() + ' km away';
  }



}