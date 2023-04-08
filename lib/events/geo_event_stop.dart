part of flutter_bloc_geo;

/*
 * GeoEventStart is fired to request that the system stops poling for 
 * GEOUpdates.
 * 
*/
class GeoEventStop extends GeoEvent {
  // final String username;
  // final String password;

  const GeoEventStop();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GeoEventStop { }';
}
