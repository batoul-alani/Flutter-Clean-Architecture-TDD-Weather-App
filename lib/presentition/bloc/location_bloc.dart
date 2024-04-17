import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecases/get_current_location_usecase.dart';
import 'package:weather_app/presentition/bloc/location_event.dart';
import 'package:weather_app/presentition/bloc/location_state.dart';
import 'package:rxdart/rxdart.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  LocationBloc(this.getCurrentLocationUseCase) : super(LocationEmpty()) {
    on<OnCityChanged>((event, emit) async {
      emit(LocationLoading());
      final result = await getCurrentLocationUseCase.execute(event.cityName);
      result.fold((failure) {
        emit(LocationLoadFailue(failure.message));
      }, (data) {
        emit(LocationLoaded(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) =>
    ((events, mapper) => events.debounceTime(duration).flatMap(mapper));
