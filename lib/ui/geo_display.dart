part of flutter_bloc_geo;

class GeoDisplayWidget extends StatelessWidget {
  GeoDisplayWidget({Key? key, required this.update})
      //: assert(userRepository != null),
      : super(key: key);
  final GeoPosition update;

  @override
  Widget build(BuildContext context) {
    return GeoInfoWidget(
      position: update,
      //lastUpdate:update.lastUpdate,
    );
  }
}
