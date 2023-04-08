part of flutter_bloc_geo;

/*
 * Event is fired when a GEO update is available.  This 
 * will contain all the geo information available.
*/
class GeoEventUpdate extends GeoEvent {
  
  final GeoPosition position;

  const GeoEventUpdate( this.position);

  @override
  List<Object> get props => [position];

  @override
  String toString() => 'GeoEventUpdate { isAvailable: $position} }';

  factory GeoEventUpdate.fromPosition(GeoPosition position) {
    return GeoEventUpdate( position);
  }
}
