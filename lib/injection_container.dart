import 'package:get_it/get_it.dart';
import 'package:weather_app/data/data_sources/remote_data_source.dart';
import 'package:weather_app/data/repositories/location_repository_impl.dart';
import 'package:weather_app/domain/repositories/location_repository.dart';
import 'package:weather_app/domain/usecases/get_current_location_usecase.dart';
import 'package:weather_app/presentition/bloc/location_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future <void> setUpLocator() async{
  // bloc
  locator.registerFactory(() => LocationBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentLocationUseCase(locator()));

  // repositoy
  locator.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(locationRemoteDataSource: locator()));

  // data source
  locator.registerLazySingleton<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl(client: locator()));

  // http
  locator.registerLazySingleton(() => http.Client());
}
