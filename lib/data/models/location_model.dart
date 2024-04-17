import 'package:weather_app/domain/entities/location.dart';

class LocationModel extends LocationEntity {
  const LocationModel(
      {required super.name,
      required super.region,
      required super.country,
      required super.lat,
      required super.lon,
      required super.tzId,
      required super.localtimeEpoch,
      required super.localtime});

  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
      name: json["name"],
      region: json["region"],
      country: json["country"],
      lat: json["lat"],
      lon: json["lon"],
      tzId: json["tz_id"],
      localtimeEpoch: json["localtime_epoch"],
      localtime: json["localtime"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
      };

      LocationEntity toEntity() => LocationEntity(name: name, region: region, country: country, lat: lat, lon: lon, tzId: tzId, localtimeEpoch: localtimeEpoch, localtime: localtime);
}
