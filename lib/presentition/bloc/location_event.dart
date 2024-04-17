import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable{
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class OnCityChanged extends LocationEvent{
  final String cityName;
  const OnCityChanged(this.cityName);

   @override
  List<Object?> get props => [cityName];

}