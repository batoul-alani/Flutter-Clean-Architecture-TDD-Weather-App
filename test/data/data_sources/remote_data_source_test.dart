import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/data/data_sources/remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/location_model.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late LocationRemoteDataSourceImpl locationRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    locationRemoteDataSourceImpl =
        LocationRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String cityName = "London";

  // First, internet, server error, parse data,
  group("get current location", () {
    // Getting data successfully

    test("should return location model when the response code is 200",
        () async {
      /// We have to STUB data to make sure mock client returns the right response data when we call get current location endpoint
      /// STUB: means returning  fake object the mock method is called

      // arrange
      when(mockHttpClient
              .get(Uri.parse(Constants.currentLoctionByName(cityName))))
          .thenAnswer((realInvocation) async => http.Response(
              readJson("/helpers/dummy_data/dummy_location_response.json"),
              200));
      // act
      final result =
          await locationRemoteDataSourceImpl.getCurrentLocation(cityName);

      // assert
      expect(result, isA<LocationModel>());
    });

    // Faild while getting data
    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      //arrange
      when(
        mockHttpClient.get(Uri.parse(Constants.currentLoctionByName(cityName))),
      ).thenAnswer((_) async => http.Response('Not found', 404));

      //act
      final result = locationRemoteDataSourceImpl.getCurrentLocation(cityName);

      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
