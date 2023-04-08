part of flutter_bloc_geo;
class GeoStateError extends GeoState {
  final String error;

  const GeoStateError( this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GeoStateError { error: $error }';
}