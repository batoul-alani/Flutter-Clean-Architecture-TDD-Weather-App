class Constants {
  static const String baseUrl =
      "http://api.weatherapi.com/v1/current.json";
  // ?q=London,uk&APPID=$appId";
  static const String appId = "d80f43a7576f4903811152214241504";
  static String currentLoctionByName(String cityName) =>
      "$baseUrl?key=d80f43a7576f4903811152214241504  &q=$cityName&aqi=no";
}
