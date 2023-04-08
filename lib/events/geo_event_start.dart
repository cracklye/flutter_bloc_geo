part of flutter_bloc_geo;
/*
 * GeoEventStart is fired to request that the system starts poling for 
 * GEOUpdates.
 * 
*/
class GeoEventStart extends GeoEvent {
  // final String username;
  // final String password;

  const GeoEventStart();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GeoEventStart { }';
}
