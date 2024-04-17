import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/entities/location.dart';
import 'package:weather_app/domain/usecases/get_current_location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetCurrentLocationUseCase getCurrentLocationUseCase;

  // To test abstract class like location_repository we use Mockito package in dev_dependencies,
  // after creating test helper we can call MockLocationRepository

  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    getCurrentLocationUseCase =
        GetCurrentLocationUseCase(mockLocationRepository);
  });

  // We want to insure that reopsitory is actually called and the data simply change in usecase

  const testLocationDetails = LocationEntity(
      name: "London",
      region: "City of London, Greater London",
      country: "United Kingdom",
      lat: 51.52,
      lon: -0.11,
      tzId: "Europe/London",
      localtimeEpoch: 1713195851,
      localtime: "2024-04-15 16:44");
  const testCityName = "London";

  test("Should get current location details from repository", () async {
    /// arrange
    // In ARRANGE we need to define some fanctionality to the mocked instance of the repository

    when(mockLocationRepository.getLocation(testCityName))
        .thenAnswer((_) async => const Right(testLocationDetails));

    /// act
    // In ACT steps should cover the main thing to be tested

    final result = await getCurrentLocationUseCase.execute(testCityName);

    /// assert
    // In ASSERT we verify whether the unit behaves as expected

    expect(result, const Right(testLocationDetails));
  });
}
