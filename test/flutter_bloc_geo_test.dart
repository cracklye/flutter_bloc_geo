import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_geo/flutter_bloc_geo.dart';

import 'package:test/test.dart';

class MockGeoProvider implements IGeoProvider {
  final GeoPosition position;
  final GeolocatorPermission permission;
  final int streamMode;
  static int exception = 99;
  const MockGeoProvider(
      {this.position = const GeoPosition(),
      this.permission = GeolocatorPermission.Enabled,
      this.streamMode = 0});

  @override
  Future<GeoPosition> getCurrentPosition() {
    if (streamMode == exception) throw UnimplementedError();

    return Future.value(position);
  }

  @override
  Stream<GeoPosition> getPositionStream() {
    if (streamMode == 0) {
      return Stream<GeoPosition>.fromIterable([]);
    } else if (streamMode == 1) {
      return Stream<GeoPosition>.fromIterable([position]);
    }
    //throw an error
    throw UnimplementedError();
  }

  @override
  Future<bool> isLocationServiceEnabled() {
    return Future.value(permission == GeolocatorPermission.Enabled);
  }

  @override
  Future<GeolocatorPermission> validatePermission() {
    return Future.value(permission);
  }
}

void main() {
  group('GeoBloc', () {
    
    test('initial state is correct',(){
      var bloc = GeoBloc(geolocator: MockGeoProvider());
      expect(bloc.state , TypeMatcher<GeoStateInitial>());
    });

    blocTest<GeoBloc, GeoState>(
      'emits [GeoStateLoading] when starting',
      build: () => GeoBloc(geolocator: MockGeoProvider()),
      act: (bloc) => bloc.add(GeoEventStart()),
      expect: () => const <GeoState>[const GeoStateLoading()],
    );

    blocTest<GeoBloc, GeoState>(
      'emits [GeoStateLoading, GeoStateError] when exception occurs',
      build: () => GeoBloc(
          geolocator: MockGeoProvider(streamMode: MockGeoProvider.exception)),
      act: (bloc) => bloc.add(GeoEventStart()),
      expect: () => const <GeoState>[
        const GeoStateLoading(),
        const GeoStateError("UnimplementedError")
      ],
    );
    blocTest<GeoBloc, GeoState>(
      'emits [GeoStateLoading, GeoStateUpdate] when updated',
      build: () => GeoBloc(geolocator: MockGeoProvider()),
      act: (bloc) => bloc.add(GeoEventUpdate(GeoPosition())),
      expect: () => const <TypeMatcher<GeoState>>[
        TypeMatcher<GeoStateUpdate>()
        //const GeoStateUpdate(GeoPosition())
      ],
    );

    // test('initial state is 0', () async {
    //   await expectLater(
    //       geoBloc, emitsInOrder([TypeMatcher<GeoStateInitial>()]));
    // });

    // test('Update - is not available', () async {
    //   await expectLater(geoBloc.mapEventToState(GeoEventUpdate()),
    //       emitsInOrder([TypeMatcher<GeoStateUpdate>()]));
    // });

    // test('EventStop - no existing to stop', () async {
    //   await expectLater(geoBloc.mapEventToState(GeoEventStop()),
    //       emitsInOrder([TypeMatcher<GeoStateInitial>()]));
    // });

    // test('EventStart - Disabled', () async {
    //   provider.permission = GeolocatorPermission.IsDisabled;
    //   await expectLater(
    //       geoBloc.mapEventToState(GeoEventStart()),
    //       emitsInOrder(
    //           [TypeMatcher<GeoStateLoading>(), TypeMatcher<GeoStateError>()]));
    // });
    // test('EventStart - Denied forever', () async {
    //   provider.permission = GeolocatorPermission.DeniedForever;
    //   await expectLater(
    //       geoBloc.mapEventToState(GeoEventStart()),
    //       emitsInOrder(
    //           [TypeMatcher<GeoStateLoading>(), TypeMatcher<GeoStateError>()]));
    // });
    // test('EventStart - Denied', () async {
    //   provider.permission = GeolocatorPermission.Denied;
    //   await expectLater(
    //       geoBloc.mapEventToState(GeoEventStart()),
    //       emitsInOrder(
    //           [TypeMatcher<GeoStateLoading>(), TypeMatcher<GeoStateError>()]));
    // });
    // test('EventStart - Success returns 1', () async {
    //   provider.permission = GeolocatorPermission.Enabled;
    //   provider.position = GeoPosition(accuracy: 4, altitude: 4, floor: 42);
    //   provider.streamMode = 1;

    //   await expectLater(geoBloc.mapEventToState(GeoEventStart()),
    //       emitsInOrder([TypeMatcher<GeoStateLoading>()]));
    // });

    // test('EventStart - Success returns 0', () async {
    //   provider.permission = GeolocatorPermission.Enabled;
    //   provider.position = GeoPosition(accuracy: 4, altitude: 4, floor: 42);
    //   provider.streamMode = 0;

    //   await expectLater(geoBloc.mapEventToState(GeoEventStart()),
    //       emitsInOrder([TypeMatcher<GeoStateLoading>()]));
    // });

    // test('EventStart - Success with exception', () async {
    //   provider.permission = GeolocatorPermission.Enabled;
    //   provider.position = GeoPosition(accuracy: 4, altitude: 4, floor: 42);
    //   provider.streamMode = MockGeoProvider.exception;

    //   await expectLater(
    //       geoBloc.mapEventToState(GeoEventStart()),
    //       emitsInOrder(
    //           [TypeMatcher<GeoStateLoading>(), TypeMatcher<GeoStateError>()]));
    // });

    // test('Event Request - Disabled', () async {
    //   provider.permission = GeolocatorPermission.IsDisabled;
    //   await expectLater(geoBloc.mapEventToState(GeoEventRequest()),
    //       emitsInOrder([TypeMatcher<GeoStateError>()]));
    // });
    // test('EventRequest - Denied forever', () async {
    //   provider.permission = GeolocatorPermission.DeniedForever;
    //   await expectLater(geoBloc.mapEventToState(GeoEventRequest()),
    //       emitsInOrder([TypeMatcher<GeoStateError>()]));
    // });
    // test('EventRequest - Denied', () async {
    //   provider.permission = GeolocatorPermission.Denied;
    //   await expectLater(geoBloc.mapEventToState(GeoEventRequest()),
    //       emitsInOrder([TypeMatcher<GeoStateError>()]));
    // });

    // test('EventRequest - Exception', () async {
    //   provider.permission = GeolocatorPermission.Enabled;
    //   provider.streamMode = MockGeoProvider.exception;
    //   await expectLater(geoBloc.mapEventToState(GeoEventRequest()),
    //       emitsInOrder([TypeMatcher<GeoStateError>()]));
    // });

    // test('EventRequest - Success', () async {
    //   provider.permission = GeolocatorPermission.Enabled;
    //   provider.position = GeoPosition(accuracy: 4, altitude: 4, floor: 42);

    //   await expectLater(
    //       geoBloc.mapEventToState(GeoEventRequest()), emitsInOrder([]));
    // });

    // test('EventRequest - Success2', () async {
    //   provider.permission = GeolocatorPermission.Enabled;
    //   provider.position = GeoPosition(accuracy: 4, altitude: 4, floor: 42);

    //    expectLater(
    //       geoBloc,
    //       emitsInOrder(
    //           [TypeMatcher<GeoStateInitial>(), TypeMatcher<GeoStateUpdate>()]));
    //           geoBloc.mapEventToState(GeoEventRequest());
    // });
  });
}
