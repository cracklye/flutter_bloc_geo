# flutter_bloc_geo
This package provides a Bloc that provides the users current geo location.  It will do that 
either through calling the location a single time, or through monitoring the current location.  

## Events

- GeoEventStart - This will connect to the IGeoProvider and register to watch the stream of locations.   If an error occurrs then the state will be returned as an GeoStateError.
- GeoEventRequest - This will request the current location as a one off.  This can be called before GeoEventStart but it is not always guaranteed to return a result. 
- GeoEventStop - this will stop the stream from the IGeoProvider if it is running and return to the initial state.
- GeoEventUpdate - This is called when an update has been recieved, this should normally only be used in testing or by the Bloc itself.



## Example

### Import
Import the package into the project

```
import 'package:flutter_bloc_geo/flutter_bloc_geo.dart';
```

### Block Provider
Create the bloc provider this at the root of your application.  The GeolocatorProvider must be provided depending on your platform.  The 
GeolocatorProvider should work for Android, IOS, web but not for Windows.  

```
 BlocProvider<GeoBloc>(
    create: (context) => GeoBloc(geolocator: GeolocatorProvider())
    ..add(
        GeoEventRequest(),
    )),
                    
```

### Bloc Builder

```
BlocBuilder<GeoBloc, GeoState>(
    builder: (BuildContext context, GeoState state) {
        //Do actions based on the state
    }); 

```            

### 

If you need to access the bloc to fire off events then it can be done like this: 
```
final GeoBloc geoBloc = BlocProvider.of<GeoBloc>(context);
 geoBloc.add(const GeoEventStart());
```

## Running Tests

To run the tests
```
flutter test
```