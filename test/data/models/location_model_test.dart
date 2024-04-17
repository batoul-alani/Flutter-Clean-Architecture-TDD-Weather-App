import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/location_model.dart';
import 'package:weather_app/domain/entities/location.dart';

import '../../helpers/json_reader.dart';

void main() {
  /// Here we have three main tests,
  /// First, the model that we have created equal with the entities at the domain layer
  setUp(() {});

  const testLocationModel = LocationModel(
      name: "London",
      region: "City of London, Greater London",
      country: "United Kingdom",
      lat: 51.52,
      lon: -0.11,
      tzId: "Europe/London",
      localtimeEpoch: 1713302014,
      localtime: "2024-04-16 22:13");

  test("Should be a subcclass of location entity", () {
    // here we don't have ACT or ARRANGE phases only ASSERT

    // assert
    expect(testLocationModel, isA<LocationEntity>());
  });

  /// Seconds, does the frommodel json returns a valid model
  test("Should return a valid model from json", () {
    // arrange
    final Map<String, dynamic> jsonMap = json
        .decode(readJson("/helpers/dummy_data/dummy_location_response.json"));

    // act
    final LocationModel locationModel = LocationModel.fromMap(jsonMap);

    // assert
    expect(locationModel, equals(testLocationModel));
  });

  /// Third, does the json model return a json map
  test("Should return a json map containing proper data", () {
    // act
    final Map<String, dynamic> json = testLocationModel.toJson();

    // assert
    final expectedJsonResult = {
      "name": "London",
      "region": "City of London, Greater London",
      "country": "United Kingdom",
      "lat": 51.52,
      "lon": -0.11,
      "tz_id": "Europe/London",
      "localtime_epoch": 1713302014,
      "localtime": "2024-04-16 22:13"
    };
    expect(json, equals(expectedJsonResult));
  });
}
