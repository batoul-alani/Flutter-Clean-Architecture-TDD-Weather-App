import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/location.dart';
import 'package:weather_app/presentition/bloc/location_bloc.dart';
import 'package:weather_app/presentition/bloc/location_event.dart';
import 'package:weather_app/presentition/bloc/location_state.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetCurrentLocationUseCase mockGetCurrentLocationUseCase;
  late LocationBloc locationBloc;

  setUp(() {
    mockGetCurrentLocationUseCase = MockGetCurrentLocationUseCase();
    locationBloc = LocationBloc(mockGetCurrentLocationUseCase);
  });

  const testLocationEntity = LocationEntity(
      name: "London",
      region: "City of London, Greater London",
      country: "United Kingdom",
      lat: 51.52,
      lon: -0.11,
      tzId: "Europe/London",
      localtimeEpoch: 1713302014,
      localtime: "2024-04-16 22:13");

  const String cityName = "London";
  test("initial state should be empty", () {
    expect(locationBloc.state, LocationEmpty());
  });

  blocTest<LocationBloc, LocationState>(
    'should emits [LocationLoading, LocationLoaded] when OnCityChanged is added.',
    // build phase like arrange phase
    build: () {
      when(mockGetCurrentLocationUseCase.execute(cityName)).thenAnswer(
          (realInvocation) async => const Right(testLocationEntity));
      return locationBloc;
    },

    act: (bloc) => bloc.add(const OnCityChanged(cityName)),

    // because of we add transformer in bloc we need to add wait here
    wait: const Duration(milliseconds: 500),

    // expect phasse like assert phase
    expect: () => [LocationLoading(), const LocationLoaded(testLocationEntity)],
  );

   blocTest<LocationBloc, LocationState>(
    'should emits [LocationLoading, LocationFailuer] when OnCityChanged is added.',
    // build phase like arrange phase
    build: () {
      when(mockGetCurrentLocationUseCase.execute(cityName)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure("Server Failure")));
      return locationBloc;
    },

    act: (bloc) => bloc.add(const OnCityChanged(cityName)),

    // because of we add transformer in bloc we need to add wait here
    wait: const Duration(milliseconds: 500),
    
    // expect phasse like assert phase
    expect: () => [LocationLoading(), const LocationLoadFailue("Server Failure")],
  );
}
