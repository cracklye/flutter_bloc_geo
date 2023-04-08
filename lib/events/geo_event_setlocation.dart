part of flutter_bloc_geo;

class GeoEventSetLocation extends GeoEvent {
  // final String username;
  // final String password;
  final double lat;
  final double lng;
  const GeoEventSetLocation(this.lat, this.lng);

  @override
  List<Object> get props => [lat, lng];

  @override
  String toString() => 'GeoEventRequest { $lat, $lng}';
}
