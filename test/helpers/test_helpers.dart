import 'package:mockito/annotations.dart';
import 'package:weather_app/data/data_sources/remote_data_source.dart';
import 'package:weather_app/domain/repositories/location_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/usecases/get_current_location_usecase.dart';

@GenerateMocks([
  LocationRepository,
  LocationRemoteDataSource,
  GetCurrentLocationUseCase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
