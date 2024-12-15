class IpInfoModel {
  late final String countryName;
  late final String reginName;
  late final String cityName;
  late final String zipCode;
  late final String timeZone;
  late final String internetServiceProvider;
  late final String query;

  IpInfoModel(
      {required this.cityName,
      required this.countryName,
      required this.internetServiceProvider,
      required this.query,
      required this.reginName,
      required this.timeZone,
      required this.zipCode});

  IpInfoModel.fromJson(Map<String, dynamic> jsonData) {
    cityName = jsonData['counrty'] ?? 'unkwon';
    reginName = jsonData['regionName'] ?? "unkwon ";
    cityName = jsonData['city'] ?? "unkwon ";
    zipCode = jsonData['zip'] ?? " unkwon";
    timeZone = jsonData['timezone'] ?? " unkwon";
    internetServiceProvider = jsonData['isp'] ?? "unkwon ";
    query = jsonData['query'] ?? "no aviable ";
  }
}
