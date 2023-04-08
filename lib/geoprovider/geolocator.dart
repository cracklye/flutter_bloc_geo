part of flutter_bloc_geo;

class GeolocatorProvider extends IGeoProvider {
  const GeolocatorProvider();

  Future<GeoPosition> getCurrentPosition() {
    return Geolocator.getCurrentPosition()
        .then((value) async => GeoPosition.fromMap(value.toJson()));
  }

  Future<GeolocatorPermission> validatePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //return Future.error('Location services are disabled.');
      return GeolocatorPermission.IsDisabled;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return GeolocatorPermission.DeniedForever;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return GeolocatorPermission.Denied;
      }
    }

    return GeolocatorPermission.Enabled;
  }

  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Stream<GeoPosition> getPositionStream() {
    return Geolocator.getPositionStream()
        .map((value) => GeoPosition.fromMap(value.toJson()));
  }
}
