class VpnInfoModel {
  late final String hostName;
  late final String ip;
  late final String ping;
  late final String speed;
  late final String countryLongName;
  late final String countryShortName;
  late final String vpnSessionNum;
  late final String base64OpenVpnConfigrationData;

  VpnInfoModel({
    required this.base64OpenVpnConfigrationData,
    required this.countryLongName,
    required this.countryShortName,
    required this.hostName,
    required this.ip,
    required this.vpnSessionNum,
    required this.ping,
    required this.speed,
  });

  VpnInfoModel.fromJson(Map<String, dynamic> jsonData) {
    hostName = jsonData["HostName"] ?? " ";
    ip = jsonData["IP"] ?? " ";
    ping = jsonData["Ping"]?.toString() ?? " ";
    speed = jsonData["Speed"]?.toString() ?? "0";
    countryLongName = jsonData["CountryLong"] ?? " ";
    countryShortName = jsonData["CountryShort"] ?? " ";
    vpnSessionNum = jsonData["NumVpnSessions"]?.toString() ?? "0";
    base64OpenVpnConfigrationData = jsonData["OpenVPN_ConfigData_Base64"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "HostName": hostName,
      "IP": ip,
      "Ping": ping,
      "Speed": speed,
      "CountryLong": countryLongName,
      "countryShort": countryShortName,
      "NumVpnSesstions": vpnSessionNum,
      "OpenVPN_ConfigData_Base64": base64OpenVpnConfigrationData,
    };
  }
}
