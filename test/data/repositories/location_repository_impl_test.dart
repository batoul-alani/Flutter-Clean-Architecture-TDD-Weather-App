import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/models/location_model.dart';
import 'package:weather_app/data/repositories/location_repository_impl.dart';
import 'package:weather_app/domain/entities/location.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockLocationRemoteDataSource mockLocationRemoteDataSource;
  late LocationRepositoryImpl locationRepositoryImpl;

  setUp(() {
    mockLocationRemoteDataSource = MockLocationRemoteDataSource();
    locationRepositoryImpl = LocationRepositoryImpl(
        locationRemoteDataSource: mockLocationRemoteDataSource);
  });

  const testLocationModel = LocationModel(
      name: "London",
      region: "City of London, Greater London",
      country: "United Kingdom",
      lat: 51.52,
      lon: -0.11,
      tzId: "Europe/London",
      localtimeEpoch: 1713302014,
      localtime: "2024-04-16 22:13");

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
  group("get current location", () {
    // First, the data souurce returns data
    test(
        "Should return curent location when a call to data source is sucsessful",
        () async {
      // Arrange
      when(mockLocationRemoteDataSource.getCurrentLocation(cityName))
          .thenAnswer((_) async => testLocationModel);

      // Act
      final result = await locationRepositoryImpl.getLocation(cityName);

      // Assert
      expect(result,
          equals(const Right<Failure, LocationEntity>(testLocationEntity)));
    });

    // Second, the data source returns server exception
    test(
        "Should return ServerException when a call to data source is Unsucsessful",
        () async {
      // Arrange
      when(mockLocationRemoteDataSource.getCurrentLocation(cityName))
          .thenThrow(ServerException());

      // Act
      final result = await locationRepositoryImpl.getLocation(cityName);

      // Assert
      expect(result, equals(const Left(ServerFailure("An error has occured"))));
    });

    // Third, the data source returns server connection error
    test(
        "Should return SocketException when a call to data source is Unsucsessful",
        () async {
      // Arrange
      when(mockLocationRemoteDataSource.getCurrentLocation(cityName))
          .thenThrow(const SocketException(""));

      // Act
      final result = await locationRepositoryImpl.getLocation(cityName);

      // Assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure("Failed to connect to the internet"))));
    });
  });
}
