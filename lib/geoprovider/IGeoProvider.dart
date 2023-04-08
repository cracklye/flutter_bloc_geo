part of flutter_bloc_geo;

enum GeolocatorPermission { Enabled, IsDisabled, DeniedForever, Denied }

abstract class IGeoProvider {

  const IGeoProvider(); 

  Future<GeoPosition> getCurrentPosition();

  Future<GeolocatorPermission> validatePermission();

  Future<bool> isLocationServiceEnabled();

  Stream<GeoPosition> getPositionStream() ; 

}
