part of flutter_bloc_geo;

class GeoStateUpdate extends GeoState {
  final GeoPosition position;

 const GeoStateUpdate(
    this.position,
  );

  @override
  List<Object> get props => [position];

  @override
  String toString() => 'GeoStateUpdate { isAvailable: $position}';

  factory GeoStateUpdate.fromEvent(GeoEventUpdate update) {
    return GeoStateUpdate(
      update.position,
    );
  }
}
