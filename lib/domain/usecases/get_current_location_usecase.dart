import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/location.dart';
import 'package:weather_app/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository locationRepository;

  GetCurrentLocationUseCase(this.locationRepository);

  Future<Either<Failure, LocationEntity>> execute(String cityName) =>
      locationRepository.getLocation(cityName);
}
