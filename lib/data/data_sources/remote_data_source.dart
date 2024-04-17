import 'dart:convert';

import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/data/models/location_model.dart';
import 'package:http/http.dart' as http;

abstract class LocationRemoteDataSource {
  Future<LocationModel> getCurrentLocation(String cityName);
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  final http.Client client;
  LocationRemoteDataSourceImpl({required this.client});

  @override
  Future<LocationModel> getCurrentLocation(String cityName) async {
    final response =
        await client.get(Uri.parse(Constants.currentLoctionByName(cityName)));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      print(json.decode(response.body)["location"]);
      return LocationModel.fromMap(json.decode(response.body)["location"]);
    } else {
      throw ServerException();
    }
  }
}
