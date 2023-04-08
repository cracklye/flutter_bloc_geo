part of flutter_bloc_geo;

class GeoInfoWidget extends StatelessWidget {
  GeoInfoWidget({Key? key, required this.position})

      //: assert(userRepository != null),
      : super(key: key);
  final GeoPosition position;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(title: Text("Latitude : ${position.latitude}")),
        ListTile(title: Text("longitude : ${position.longitude}")),
        //ListTile(title: Text("mocked : ${position.mocked}")),
        ListTile(title: Text("speed : ${position.speed}")),
        ListTile(title: Text("speedAccuracy : ${position.speedAccuracy}")),
        ListTile(title: Text("timestamp : ${position.timestamp}")),
        // ListTile(title: Text("isSet : ${position.isSet}")),
        ListTile(title: Text("heading : ${position.heading}")),
        ListTile(title: Text("altitude : ${position.altitude}")),
        ListTile(title: Text("accuracy : ${position.accuracy}")),
        // ListTile(title: Text("lastUpdate : ${position.lastUpdate}")),
      ],
    ));
  }
}
