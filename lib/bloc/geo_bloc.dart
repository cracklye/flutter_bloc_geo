part of flutter_bloc_geo;

class GeoBloc extends Bloc<GeoEvent, GeoState> {
  IGeoProvider geolocator;
  StreamSubscription<GeoPosition>? positionStream;

  GeoBloc({this.geolocator = const GeolocatorProvider()})
      : super(GeoStateInitial()) {
    on<GeoEventStart>(_onStart);
    on<GeoEventStop>(_onStop);
    on<GeoEventRequest>(_onRequest);
    on<GeoEventUpdate>(_onUpdate);
    on<GeoEventSetLocation>(_onGeoEventSetLocation);
  }

  GeoState get initialState => GeoStateInitial();

  @override
  void onTransition(Transition<GeoEvent, GeoState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void _onGeoEventSetLocation(
      GeoEventSetLocation event, Emitter<GeoState> emit) async {
    print("GeoBloc._onGeoEventSetLocation: GeoEventRequest $event");
    try {
      emit(GeoStateUpdate(
          GeoPosition(latitude: event.lat, longitude: event.lng)));
    } catch (error) {
      print("GeoBloc._onGeoEventSetLocation: Error occurred $error");
    }
  }

  void _onUpdate(GeoEventUpdate event, Emitter<GeoState> emit) async {
    print("GeoBloc._onUpdate: GeoEventRequest $event");
    try {
      emit(GeoStateUpdate.fromEvent(event));
    } catch (error) {
      print("GeoBloc._onUpdate: Error occurred $error");
    }
  }

  void _onRequest(GeoEventRequest event, Emitter<GeoState> emit) async {
    print("GeoBloc._onRequest: GeoEventRequest $event");

    emit(GeoStateLoading());
    

    try {
      if (positionStream != null) {
        positionStream?.cancel();
      }

      if (await _onHandlePermission(emit)) {
        var pos = await geolocator.getCurrentPosition();
        this.add(GeoEventUpdate.fromPosition(pos));
      }
    } catch (error) {
      print("_onRequest Error :$error");
      emit(GeoStateError(error.toString()));
    }
  }

  void _onStop(GeoEventStop event, Emitter<GeoState> emit) async {
    print("GeoBloc._onStop: GeoEventStop $event");
    if (positionStream != null) positionStream!.cancel();
    positionStream = null;
    emit(GeoStateInitial());
  }

  void _onStart(GeoEventStart event, Emitter<GeoState> emit) async {
    print("GeoBloc._onStart: GeoEventStart $event");
    emit(GeoStateLoading());

    try {
      print("GeoBloc._onStart: Cancelling the stream");
      if (positionStream != null) {
        positionStream?.cancel();
      }
      print("GeoBloc._onStart: About to get permissions");
      if (await _onHandlePermission(emit)) {
        print("GeoBloc._onStart: Handling permissions response");
        positionStream = geolocator.getPositionStream().listen(
            (GeoPosition position) =>
                add(GeoEventUpdate.fromPosition(position)))
          ..onError((error) {
            print("_onRequest Error :$error");
            // emit(GeoStateError(error.toString()));
          });
      }
    } catch (error) {
      print("GeoBloc_onStart Error :$error");
      emit(GeoStateError(error.toString()));
    }
  }

  Future<bool> _onHandlePermission(Emitter<GeoState> emit) async {
    var permission = await geolocator.validatePermission();

    if (permission == GeolocatorPermission.IsDisabled) {
      emit(
          GeoStateError("Geolocation permissions are disabled on this device"));
    } else if (permission == GeolocatorPermission.DeniedForever) {
      emit(GeoStateError("Geolocation permissions are denied forever"));
    } else if (permission == GeolocatorPermission.Denied) {
      emit(GeoStateError("Geolocation permissions are denied"));
    } else {
      return true;
    }
    return false;
  }

  // @override
  // Stream<GeoState> mapEventToState(GeoEvent event) async* {
  //   if (event is GeoEventStart) {
  //     yield GeoStateLoading();

  //     try {
  //       positionStream?.cancel();
  //       print("1");

  //       var permission = await geolocator.validatePermission();

  //       if (permission == GeolocatorPermission.IsDisabled) {
  //         yield GeoStateError(
  //             error: "Geolocation permissions are disabled on this device");
  //       } else if (permission == GeolocatorPermission.DeniedForever) {
  //         yield GeoStateError(
  //             error: "Geolocation permissions are disabled on this device");
  //       } else if (permission == GeolocatorPermission.Denied) {
  //         yield GeoStateError(
  //             error: "Geolocation permissions are disabled on this device");
  //       } else {
  //         positionStream = geolocator.getPositionStream().listen(
  //             (GeoPosition position) =>
  //                 add(GeoEventUpdate.fromPosition(position)));
  //       }
  //     } catch (error) {
  //       print(error);
  //       yield GeoStateError(error: error.toString());
  //     }
  //   } else if (event is GeoEventStop) {
  //     print("GeoBloc.mapEventToState: GeoEventStop $event");
  //     if (positionStream != null) positionStream!.cancel();
  //     positionStream = null;
  //     yield GeoStateInitial();
  //   } else if (event is GeoEventRequest) {
  //     print("GeoBloc.mapEventToState: GeoEventRequest $event");
  //     // Position p = await geolocator.getCurrentPosition();
  //     // print("p=$p");
  //     // this.add(GeoEventUpdate.fromPosition(p));
  //     try {
  //       var permission = await geolocator.validatePermission();

  //       if (permission == GeolocatorPermission.IsDisabled) {
  //         yield GeoStateError(
  //             error: "Geolocation permissions are disabled on this device");
  //       } else if (permission == GeolocatorPermission.DeniedForever) {
  //         yield GeoStateError(
  //             error: "Geolocation permissions are disabled on this device");
  //       } else if (permission == GeolocatorPermission.Denied) {
  //         yield GeoStateError(
  //             error: "Geolocation permissions are disabled on this device");
  //       } else {
  //         print("Adding the event update to the bloc");
  //         var pos = await geolocator.getCurrentPosition();
  //         this.add(GeoEventUpdate.fromPosition(pos));
  //       }
  //     } catch (error) {
  //       print(error);
  //       yield GeoStateError(error: error.toString());
  //     }
  //   } else if (event is GeoEventUpdate) {
  //     print("GeoBloc.mapEventToState: GeoEventUpdate $event");
  //     yield GeoStateUpdate.fromEvent(event);
  //     print("GeoBloc.mapEventToState: GeoEventUpdate Completed");
  //   }
  // }
}
