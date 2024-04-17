import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/data_sources/remote_data_source.dart';
import 'package:weather_app/domain/entities/location.dart';
import 'package:weather_app/domain/repositories/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;
  LocationRepositoryImpl({required this.locationRemoteDataSource});

  @override
  Future<Either<Failure, LocationEntity>> getLocation(String cityName) async {
    try {
      final result =
          await locationRemoteDataSource.getCurrentLocation(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An error has occured"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the internet"));
    }
  }
}
