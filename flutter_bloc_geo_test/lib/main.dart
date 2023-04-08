import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_geo/flutter_bloc_geo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<GeoBloc>(
            create: (context) =>
                GeoBloc(geolocator: const GeolocatorProvider()),
          ),
        ],
        child: MaterialApp(
          title: 'flutter_bloc_geo Test App',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'flutter_bloc_geo Test App'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: BlocBuilder<GeoBloc, GeoState>(
          builder: (BuildContext context, GeoState state) {
        final GeoBloc geoBloc = BlocProvider.of<GeoBloc>(context);

        return Column(
          children: [
            Text(state.toString()),
            ElevatedButton(
              child: const Text("Start"),
              onPressed: () => geoBloc.add(const GeoEventStart()),
            ),
            ElevatedButton(
              child: const Text("Stop"),
              onPressed: () => geoBloc.add(const GeoEventStop()),
            ),
            ElevatedButton(
              child: const Text("Request"),
              onPressed: () => geoBloc.add(const GeoEventRequest()),
            ),
          ],
        );
      })),
    );
  }
}
