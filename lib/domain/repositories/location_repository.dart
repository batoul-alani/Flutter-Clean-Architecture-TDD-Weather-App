import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/location.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either<Failure,LocationEntity>> getLocation(String cityName);
}
