import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entities/location.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object?> get props => [];
}

class LocationEmpty extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationEntity locationEntity;
  const LocationLoaded(this.locationEntity);

  @override
  List<Object?> get props => [locationEntity];
}

class LocationLoadFailue extends LocationState {
  final String error;
  const LocationLoadFailue(this.error);

  @override
  List<Object?> get props => [error];
}
